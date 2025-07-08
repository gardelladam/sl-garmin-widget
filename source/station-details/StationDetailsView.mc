using Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.System;

class StationDetailsView extends WatchUi.View {
    var _model as StationDetailsModel;

    function initialize(model) {
        View.initialize();
        _model = model;
    }

    function onShow() as Void {
        _model.fetchDepartures();
    }

    function onUpdate(dc as Dc) {
        var station = _model.getStation();
        dc.clear();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        dc.drawText(dc.getWidth() / 2, 40, Graphics.FONT_LARGE, station.name, Graphics.TEXT_JUSTIFY_CENTER);

        dc.drawText(dc.getWidth() / 2, 80, Graphics.FONT_SMALL, "ID: " + station.id.toString(), Graphics.TEXT_JUSTIFY_CENTER);
    }


}
