import Toybox.Lang;

class StationFilter {
    var transportMode as String;
    var directionCode as Number;

    function initialize(transportMode as String, directionCode as Number) {
        self.transportMode = transportMode;
        self.directionCode = directionCode;
    }

    function toDict() as Dictionary {
        return {
            "mode" => transportMode,
            "dir" => directionCode,
        };
    }

    static function fromDict(d as Dictionary) as StationFilter {
        return new StationFilter(d["mode"], d["dir"]);
    }
}
