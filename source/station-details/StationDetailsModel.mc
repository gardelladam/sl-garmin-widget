using Toybox.System;
import Toybox.Lang;
import Toybox.Communications;
using Toybox.WatchUi;

class StationDetailsModel {

    private var _station as Station;
    private var _departures as Array<Departure> = [];
    var isFetching as Boolean = true;
    var cursor as Number = 0;

    function initialize(station as Station) {
        _station = station;
    }

    function increaseCursor() as Void {
        if (_departures.size() == 0) {
            cursor = 0;
            return;
        }

        cursor += 1;
        
        if (cursor >= _departures.size()) {
            cursor = 0;
        }
    }

    function decreaseCursor() as Void {
        if (_departures.size() == 0) {
            cursor = 0;
            return;
        }

        cursor -= 1;

        if (cursor < 0) {
            cursor = _departures.size() - 1;
        }
    }

    function getStation() {
        return _station;
    }
    function getDepartures() as Array<Departure> {
        return _departures;
    }
  
    function fetchDepartures() as Void {
        var url = "https://transport.integration.sl.se/v1/sites/" + _station.siteId + "/departures";

        var params = {                                             
            "forecast" => "20",
        };

        var options = {                                             
            :method => Communications.HTTP_REQUEST_METHOD_GET,      
            :headers => {
                    "Content-Type" => Communications.REQUEST_CONTENT_TYPE_JSON,
                    "User-Agent" => "MyGarminApp/1.0"
        },
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
        };
        Communications.makeWebRequest(url, params, options, method(:onReceive));   
    }

    function onReceive(responseCode as Number, data as Dictionary?) as Void {
        isFetching = false;

        if (responseCode != 200 or data == null) {
            System.println("Failed to fetch data or no data received");
            return;
        }
        var departures = data["departures"];

        if (departures == null) {
            System.println("No departures key in response data");
            return;
        }
        
        _departures = filterDepartures(departures);

        System.println("FILTERED: " + _departures);
        WatchUi.requestUpdate();
    }

    function filterDepartures(departures as Array<Dictionary>) as Array<Departure> {
        var filteredDepartures = [] as Array<Departure>;

        for (var i = 0; i < _station.filters.size(); i += 1) {   
            var filter = _station.filters[i];

            for (var j = 0; j < departures.size(); j += 1) {
                var dep = departures[j] as Dictionary;
                var line = dep["line"] as Dictionary;
                var transportMode = line["transport_mode"] as String;
                var directionCode = dep["direction_code"] as Number;
               
                if (transportMode.equals(filter.transportMode) && directionCode.equals(filter.directionCode)) {
                    var destination = dep["destination"] as String;
                    var display = dep["display"] as String;
                    var scheduled = dep["scheduled"] as String;
                    var expected = dep["expected"] as String;
                    var groupOfLines = line["group_of_lines"] as String;

                    var departure = new Departure(destination, display, scheduled, expected, groupOfLines);
                    filteredDepartures.add(departure);
                }
            }
        }

        return filteredDepartures;
    }
}
