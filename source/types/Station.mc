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

    function toDict() as Dictionary {
        var fs = [] as Array<Dictionary>;
        for (var i = 0; i < filters.size(); i += 1) {
            fs.add(filters[i].toDict());
        }

        return {
            "id" => id,
            "name" => name,
            "filters" => fs,
        };
    }

    static function fromDict(d as Dictionary) as Station {
        var storedAny = d["filters"];
        if (storedAny == null) {
            storedAny = [] as Array<Dictionary>;
        }

        var stored = storedAny as Array<Dictionary>;

        var fs = [] as Array<StationFilter>;
        for (var i = 0; i < stored.size(); i += 1) {
            fs.add(StationFilter.fromDict(stored[i]));
        }

        return new Station(d["id"], d["name"], fs);
    }
}
