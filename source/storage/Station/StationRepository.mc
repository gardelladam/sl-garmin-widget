import Toybox.Lang;
using Toybox.Application.Storage;

class StationRepository {
    static const KEY = "stations_v1";

    static function load() as Array<Station> {
        var storedAny = Storage.getValue(KEY);

        if (storedAny == null) {
            return [];
        }

        var stored = storedAny as Array<Dictionary>;
        var stations = [] as Array<Station>;
        for (var i = 0; i < stored.size(); i += 1) {
            stations.add(Station.fromDict(stored[i]));
        }
        return stations;
    }

    static function save(stations as Array<Station>) as Void {
        var out = [] as Array<Dictionary>;
        for (var i = 0; i < stations.size(); i += 1) {
            out.add(stations[i].toDict());
        }
        Storage.setValue(KEY, out);
    }

    static function defaultStations() as Array<Station> {
        return [
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
}
