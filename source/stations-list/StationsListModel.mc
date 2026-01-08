using Toybox.WatchUi;
import Toybox.Lang;
using Toybox.Application.Storage;

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
    var newOption = :newOption;

    function initialize() {
        _stations = StationRepository.load();
    }

    function createMenu() as WatchUi.Menu {
        var menu = new WatchUi.Menu();
        for (var i = 0; i < _stations.size(); i++) {
            var station = _stations[i];
            menu.addItem(station.name, _symbols[i]);
        }
        menu.addItem("Lägg till", newOption);
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
