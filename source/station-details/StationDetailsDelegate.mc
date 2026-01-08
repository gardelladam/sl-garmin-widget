using Toybox.WatchUi;
class StationDetailsDelegate extends WatchUi.BehaviorDelegate {
    private var _model as StationDetailsModel;

    function initialize(model as StationDetailsModel) {
        BehaviorDelegate.initialize();
        _model = model;
    }

    function onSelect() {
        _model.fetchDepartures();
        WatchUi.requestUpdate();
        return true;
    }

    function onNextPage() {
        _model.nextPage();
        WatchUi.requestUpdate();
        return true;
    }
    function onPreviousPage() {
        _model.previousPage();
        WatchUi.requestUpdate();
        return true;
    }

    function onMenu() {
        System.println("Opening station menu");
        return true;
    }
}
