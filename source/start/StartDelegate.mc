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
        var viewModel = new StationsListModel();
        var menu = viewModel.createMenu();
        var delegate = new StationsListDelegate(viewModel);
        
        WatchUi.pushView(menu, delegate, WatchUi.SLIDE_BLINK);
    }

}