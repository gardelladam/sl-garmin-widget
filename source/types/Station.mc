import Toybox.Lang;

class Station {
    var id as Number;
    var name as String;
    var filters as Array<StationFilter>;

    function initialize(
        id as Number,
        name as String,
        filters as Array<StationFilter>
    ) {
        self.id = id;
        self.name = name;
        self.filters = filters;
    }
}
