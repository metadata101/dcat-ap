package org.fao.geonet.schema.dcatap.harvester;

import java.net.URI;
import org.fao.geonet.Util;
import org.fao.geonet.exceptions.BadInputEx;
import org.fao.geonet.exceptions.BadParameterEx;
import org.fao.geonet.kernel.DataManager;
import org.fao.geonet.kernel.harvest.harvester.AbstractParams;
import org.jdom.Element;

public class DcatApSparqlParams extends AbstractParams {
    public String url;
    public String icon = "blank.png";
    public String query = "";

    public DcatApSparqlParams(DataManager dm) {
        super(dm);
    }

    @Override
    public void create(Element node) throws BadInputEx {
        super.create(node);
        readSite(node, "");
    }

    @Override
    public void update(Element node) throws BadInputEx {
        super.update(node);
        readSite(node, url);
    }

    private void readSite(Element node, String defaultValue) throws BadInputEx {
        Element site = node.getChild("site");
        url = Util.getParam(site, "url", defaultValue).trim();
        icon = Util.getParam(site, "icon", icon);
        if (site != null && site.getChild("query") != null) {
            query = site.getChildText("query");
        }
        if (icon.isBlank()) {
            icon = "blank.png";
        }
        try {
            URI uri = URI.create(url);
            if (!("http".equalsIgnoreCase(uri.getScheme()) || "https".equalsIgnoreCase(uri.getScheme()))
                || uri.getHost() == null || uri.getUserInfo() != null || uri.getFragment() != null) {
                throw new IllegalArgumentException();
            }
        } catch (IllegalArgumentException e) {
            throw new BadParameterEx("SPARQL URL", url);
        }
    }

    @Override
    public String getIcon() {
        return icon;
    }

    @Override
    public DcatApSparqlParams copy() {
        DcatApSparqlParams copy = new DcatApSparqlParams(dm);
        copyTo(copy);
        copy.url = url;
        copy.icon = icon;
        copy.query = query;
        return copy;
    }
}
