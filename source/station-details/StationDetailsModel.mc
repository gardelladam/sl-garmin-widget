using Toybox.System;
import Toybox.Lang;
import Toybox.Communications;
using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

class StationDetailsModel {
    private var _station as Station;
    private var _departures as Array<Departure> = [];
    var isFetching as Boolean = true;

    var pageSize as Number = 4;
    var currentPage as Number = 0;

    function initialize(station as Station) {
        _station = station;
    }

    function getStation() {
        return _station;
    }
    function getDepartures() as Array<Departure> {
        return _departures;
    }

    function getPagedDepartures() as Array<Departure> {
        var startIndex = currentPage * pageSize;
        var endIndex = startIndex + pageSize;
        if (endIndex > _departures.size()) {
            endIndex = _departures.size();
        }
        return _departures.slice(startIndex, endIndex);
    }

    function nextPage() {
        var maxPage = (_departures.size() - 1) / pageSize;
        if (currentPage < maxPage) {
            currentPage += 1;
        }
    }

    function previousPage() {
        if (currentPage > 0) {
            currentPage -= 1;
        }
    }

    function fetchDepartures() as Void {
        var url =
            "https://transport.integration.sl.se/v1/sites/" +
            _station.siteId +
            "/departures";

        var params = {
            "forecast" => "20",
        };

        var options = {
            :method => Communications.HTTP_REQUEST_METHOD_GET,
            :headers => {
                "Content-Type" => Communications.REQUEST_CONTENT_TYPE_JSON,
                "User-Agent" => "MyGarminApp/1.0",
            },
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
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

        WatchUi.requestUpdate();
    }

    private function filterDepartures(
        departures as Array<Dictionary>
    ) as Array<Departure> {
        var filteredDepartures = [] as Array<Departure>;

        for (var i = 0; i < _station.filters.size(); i += 1) {
            var filter = _station.filters[i];

            for (var j = 0; j < departures.size(); j += 1) {
                var dep = departures[j] as Dictionary;
                var line = dep["line"] as Dictionary;
                var transportMode = line["transport_mode"] as String;
                var directionCode = dep["direction_code"] as Number;

                if (
                    transportMode.equals(filter.transportMode) &&
                    directionCode.equals(filter.directionCode)
                ) {
                    var destination = dep["destination"] as String;
                    var display = dep["display"] as String;
                    var scheduled = dep["scheduled"] as String;
                    var expected = dep["expected"] as String;
                    var groupOfLines = line["group_of_lines"] as String;

                    var departure = new Departure(
                        destination,
                        display,
                        scheduled,
                        expected,
                        groupOfLines,
                        dateStringToUnix(expected)
                    );

                    filteredDepartures.add(departure);
                }
            }
        }

        var n = filteredDepartures.size();
        for (var i = 0; i < n - 1; i += 1) {
            for (var j = 0; j < n - i - 1; j += 1) {
                if (
                    filteredDepartures[j].expectedTime >
                    filteredDepartures[j + 1].expectedTime
                ) {
                    var temp = filteredDepartures[j];
                    filteredDepartures[j] = filteredDepartures[j + 1];
                    filteredDepartures[j + 1] = temp;
                }
            }
        }

        return filteredDepartures;
    }

    private function dateStringToUnix(dateString as String) as Number {
        var options = {
            :year => dateString.substring(0, 4).toNumber(),
            :month => dateString.substring(5, 7).toNumber(),
            :day => dateString.substring(8, 10).toNumber(),
            :hour => dateString.substring(11, 13).toNumber(),
            :minute => dateString.substring(14, 16).toNumber(),
            :second => dateString.substring(17, 19).toNumber(),
        };

        return Gregorian.moment(options).value();
    }
}
