import Toybox.Lang;

class StationFilter {
    var transportMode as String;
    var directionCode as Number;

    function initialize(transportMode as String, directionCode as Number) {
        self.transportMode = transportMode;
        self.directionCode = directionCode;
    }
}
