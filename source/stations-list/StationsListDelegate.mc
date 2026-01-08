using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
import Toybox.Lang;

class StationsListDelegate extends WatchUi.MenuInputDelegate {
    var _model as StationsListModel;

    function initialize(model as StationsListModel) {
        MenuInputDelegate.initialize();
        _model = model;
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == _model.newOption) {
            _pushAddStation();
            return;
        }

        var station = _model.getStationById(item);

        _pushStationDetails(station);
    }

    private function _pushStationDetails(station as Station) as Void {
        var model = new StationDetailsModel(station);
        var view = new StationDetailsView(model);
        var delegate = new StationDetailsDelegate(model);

        WatchUi.pushView(view, delegate, WatchUi.SLIDE_BLINK);
    }

    private function _pushAddStation() as Void {
        var view = new AddStationView();
        var delegate = new AddStationDelegate();

        WatchUi.pushView(view, delegate, WatchUi.SLIDE_BLINK);
    }
}
