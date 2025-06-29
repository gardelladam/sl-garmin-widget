using Toybox.System;
import Toybox.Lang;

class StationDetailsModel {

    private var _station;
    
    function initialize(station) {
        _station = station;
    }

    function getStation() {
        return _station;
    }
}
