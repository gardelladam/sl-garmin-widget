using Toybox.WatchUi;
import Toybox.Lang;

class StationsListModel {
    private var _stations as Array<Station>;

    function initialize() {
        _stations = [
            new Station(:stationA, 9325, "Sundbyberg", [
                new StationFilter("METRO", 2),
                new StationFilter("TRAIN", 1),
            ]),
            new Station(:stationB, 1079, "Odenplan -> jobb", [
                new StationFilter("METRO", 2),
            ]),
            new Station(:stationC, 9001, "TC -> jobb", [
                new StationFilter("METRO", 1),
                new StationFilter("METRO", 2),
            ]),
        ];
    }

    function createMenu() as WatchUi.Menu {
        var menu = new WatchUi.Menu();
        for (var i = 0; i < _stations.size(); i++) {
            var station = _stations[i];
            menu.addItem(station[:name], station[:id]);
        }
        return menu;
    }

    function getStations() as Array<Station> {
        return _stations;
    }

    function getStationById(id as Symbol) as Station? {
        for (var i = 0; i < _stations.size(); i++) {
            if (_stations[i][:id] == id) {
                return _stations[i];
            }
        }
        return null;
    }
}
