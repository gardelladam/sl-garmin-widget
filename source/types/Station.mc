import Toybox.Lang;

class Station {
    var id as Symbol;
    var siteId as Number;
    var name as String;
    var filters as Array<StationFilter>;
  
    function initialize(id as Symbol, siteId as Number, name as String, filters as Array<StationFilter>) {
        self.id = id;
        self.siteId = siteId;
        self.name = name;
        self.filters = filters;
    }
}
