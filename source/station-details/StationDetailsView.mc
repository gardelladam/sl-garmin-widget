using Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.System;

class StationDetailsView extends WatchUi.View {
    private var _model as StationDetailsModel;
    private var _listComponent;

    function initialize(model) {
        View.initialize();
        _model = model;
    }

    function onShow() as Void {
        _model.fetchDepartures();
    }

    function onUpdate(dc as Dc) {
        var station = _model.getStation();
        var departures = _model.getDepartures();

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();

        dc.drawText(
            dc.getWidth() / 2,
            20,
            Graphics.FONT_TINY,
            station.name,
            Graphics.TEXT_JUSTIFY_CENTER
        );

        if (_model.isError) {
            dc.drawText(
                dc.getWidth() / 2,
                dc.getHeight() / 2 - 10,
                Graphics.FONT_TINY,
                "Något gick fel",
                Graphics.TEXT_JUSTIFY_CENTER
            );
            return;
        }

        if (_model.isFetching) {
            dc.drawText(
                dc.getWidth() / 2,
                dc.getHeight() / 2 - 10,
                Graphics.FONT_TINY,
                "LADDAR...",
                Graphics.TEXT_JUSTIFY_CENTER
            );
            return;
        }

        if (!departures.size().equals(0)) {
            _listComponent = new DepartureListComponent(_model);
            _listComponent.draw(dc);
        }
    }
}
