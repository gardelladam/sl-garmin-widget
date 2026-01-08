using Toybox.WatchUi;
import Toybox.Lang;

const _symbols = [
    :symbol0,
    :symbol1,
    :symbol2,
    :symbol3,
    :symbol4,
    :symbol5,
    :symbol6,
    :symbol7,
    :symbol8,
    :symbol9,
    :symbol10,
    :symbol11,
    :symbol12,
    :symbol13,
    :symbol14,
    :symbol15,
];
class StationsListModel {
    private var _stations as Array<Station>;

    function initialize() {
        _stations = [
            new Station(9325, "Sundbyberg", [
                new StationFilter("METRO", 2),
                new StationFilter("TRAIN", 1),
            ]),
            new Station(1079, "Odenplan -> jobb", [
                new StationFilter("METRO", 2),
            ]),
            new Station(9001, "TC -> jobb", [
                new StationFilter("METRO", 1),
                new StationFilter("METRO", 2),
            ]),
        ];
    }

    function createMenu() as WatchUi.Menu {
        var menu = new WatchUi.Menu();
        for (var i = 0; i < _stations.size(); i++) {
            var station = _stations[i];
            menu.addItem(station.name, _symbols[i]);
        }
        return menu;
    }

    function getStations() as Array<Station> {
        return _stations;
    }

    function getStationById(id as Symbol) as Station? {
        for (var i = 0; i < _stations.size(); i++) {
            if (_symbols[i] == id) {
                return _stations[i];
            }
        }
        return null;
    }
}
