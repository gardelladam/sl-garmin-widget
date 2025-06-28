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
        WatchUi.pushView(new StationsListView(), new StationsListDelegate(), WatchUi.SLIDE_BLINK);
    }

}