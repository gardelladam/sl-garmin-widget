using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
import Toybox.Lang;

class StationsListDelegate extends WatchUi.MenuInputDelegate  {

   var _viewModel as StationsListModel;

    function initialize(viewModel as StationsListModel) {
        MenuInputDelegate.initialize();
        _viewModel = viewModel;
    }

    function onMenuItem(item as Symbol) as Void {
        var station = _viewModel.getStationById(item);
        System.println("Selected station: " + station[:name]);
    }

    function onBack() {
        WatchUi.popView(WatchUi.SLIDE_BLINK);
        return true;
    }
}
    

    