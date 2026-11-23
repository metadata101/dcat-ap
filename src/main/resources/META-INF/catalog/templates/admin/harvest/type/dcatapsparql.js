var gnHarvesterdcatapsparql = {
  createNew: function () {
    return {
      "@id": "", "@type": "dcatapsparql", owner: [], ownerGroup: [], ownerUser: [""],
      site: {
        name: "", uuid: "", icon: "blank.png", url: "", query: "",
        account: {use: false, username: "", password: ""},
        apiKeyHeader: "Authorization", apiKey: ""
      },
      content: {validate: "NOVALIDATION", importxslt: ""},
      options: {every: "0 0 0 ? * *", oneRunOnly: false, overrideUuid: "SKIP", status: "active"},
      privileges: [{"@id": "1", operation: [{"@name": "view"}, {"@name": "dynamic"}]}],
      categories: [], info: {lastRun: [], running: false}
    };
  },
  buildResponse: function (h, $scope) {
    function value(name, text) {
      return "<" + name + ">" + _.escape(text == null ? "" : String(text)) + "</" + name + ">";
    }
    return '<node id="' + _.escape(h["@id"]) + '" type="dcatapsparql">'
      + "<ownerGroup>" + value("id", h.ownerGroup[0]) + "</ownerGroup>"
      + "<ownerUser>" + value("id", h.ownerUser[0]) + "</ownerUser>"
      + "<site>" + value("name", h.site.name) + value("url", h.site.url) + value("icon", h.site.icon)
      + value("query", h.site.query)
      + "<account>" + value("use", h.site.account.use)
      + value("username", h.site.account.username) + value("password", h.site.account.password) + "</account>"
      + value("apiKeyHeader", h.site.apiKeyHeader) + value("apiKey", h.site.apiKey) + "</site>"
      + "<options>" + value("every", h.options.every) + value("oneRunOnly", h.options.oneRunOnly)
      + value("overrideUuid", "SKIP") + value("status", h.options.status) + "</options>"
      + "<content>" + value("validate", h.content.validate) + value("importxslt", h.content.importxslt) + "</content>"
      + $scope.buildResponseGroup(h) + $scope.buildResponseCategory(h) + "</node>";
  }
};
