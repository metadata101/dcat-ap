/*
 * Copyright (C) 2001-2024 Food and Agriculture Organization of the
 * United Nations (FAO-UN), United Nations World Food Programme (WFP)
 * and United Nations Environment Programme (UNEP)
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
 *
 * Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
 * Rome - Italy. email: geonetwork@osgeo.org
 */

package org.fao.geonet.schema.dcatap.init;

import org.fao.geonet.constants.Geonet;
import org.fao.geonet.domain.Setting;
import org.fao.geonet.domain.SettingDataType;
import org.fao.geonet.kernel.GeonetworkDataDirectory;
import org.fao.geonet.kernel.setting.SettingManager;
import org.fao.geonet.repository.SettingRepository;
import org.fao.geonet.utils.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.core.Ordered;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.regex.Pattern;

/**
 * This class sets up the thesaurus files required by the DCAT-AP schema.
 * <p>
 * See config-spring-geonetwork.xml in this schema
 */
public class SchemaInitializerThesauri implements
    ApplicationListener<GeonetworkDataDirectory.GeonetworkDataDirectoryInitializedEvent>,
    Ordered {

    private static final boolean OVERWRITE_EXISTING_THESAURI = true;

    private static final String RESOURCE_TYPE_DIR = "external"; // "local" or "external"
    private static final String JAR_RDF_PATTERN = "thesaurus/**/*.rdf"; //find rdf files in the JAR

    // for each of the RDF files included in this JAR, if its not in the corresponding location in datadir, then we copy it in
    public void configureThesauruses(Path thesauriDir) throws IOException {
        PathMatchingResourcePatternResolver resolver =
            new PathMatchingResourcePatternResolver(Thread.currentThread().getContextClassLoader());
        //for each of the .rdf files
        for (Resource r : resolver.getResources(JAR_RDF_PATTERN)) {
            String fname = r.getFilename(); //i.e. thesaurus/theme/EC_ISO_Countries.rdf
            String[] subDirs = r.getURI().toURL().getPath().split(Pattern.quote("/"));
            String dir = subDirs[subDirs.length - 2]; // ie. "theme"
            ///put in - WEB-INF/data/config/codelist/external/thesauri/theme/EC_ISO_Countries.rdf
            //ensure that dirs exist
            Files.createDirectories(Paths.get(thesauriDir.toString(), RESOURCE_TYPE_DIR, "thesauri", dir));
            //full path to put the .rdf
            Path correspondingDataDirFile = Paths.get(thesauriDir.toString(), RESOURCE_TYPE_DIR, "thesauri", dir, fname);
            if (!Files.exists(correspondingDataDirFile) || OVERWRITE_EXISTING_THESAURI) {
                if (Files.exists(correspondingDataDirFile))
                    Files.delete(correspondingDataDirFile);
                //need to copy it in...
                Log.info(Geonet.THESAURUS, String.format("DCAT-AP schema initialisation - copy thesaurus: %s", fname));
                try (InputStream is = r.getInputStream()) { //auto close
                    Files.copy(is, correspondingDataDirFile);
                }
            }
        }
    }


    //when the data dir is configured, we're good to copy in our thesauruses
    @Override
    public void onApplicationEvent(GeonetworkDataDirectory.GeonetworkDataDirectoryInitializedEvent event) {
        Path thesauriDir = event.getSource().getThesauriDir();
        try {
            configureThesauruses(thesauriDir);
        } catch (IOException e) {
            Log.error(Geonet.THESAURUS, "DCAT-AP schema initialisation - load thesaurus files", e);
        }
    }

    @Override
    public int getOrder() {
        return 1;
    }
}
