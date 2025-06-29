import Toybox.Lang;

using Toybox.Application;
using Toybox.WatchUi;

class StartDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() as Boolean {
        _pushStationsList();
        return true;
    }

    private function _pushStationsList() as Void {
        var model = new StationsListModel();
        var menu = model.createMenu();
        var delegate = new StationsListDelegate(model);
        
        WatchUi.pushView(menu, delegate, WatchUi.SLIDE_BLINK);
    }

}