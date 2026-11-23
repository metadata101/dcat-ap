package org.fao.geonet.schema.dcatap.harvester;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import org.fao.geonet.kernel.GeonetworkDataDirectory;
import org.springframework.context.ApplicationListener;

public class DcatApSparqlInitializer implements
    ApplicationListener<GeonetworkDataDirectory.GeonetworkDataDirectoryInitializedEvent> {
    @Override
    public void onApplicationEvent(GeonetworkDataDirectory.GeonetworkDataDirectoryInitializedEvent event) {
        Path stylesheet = event.getSource().getWebappDir().resolve("xsl/xml/harvesting/dcatapsparql.xsl");
        try (InputStream input = getClass().getResourceAsStream("/dcat-ap/harvesting/dcatapsparql.xsl")) {
            if (input == null) {
                throw new IOException("Missing plugin harvester settings stylesheet");
            }
            Files.createDirectories(stylesheet.getParent());
            Files.copy(input, stylesheet, StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            throw new IllegalStateException("Could not install DCAT-ap SPARQL harvester settings", e);
        }
    }
}
