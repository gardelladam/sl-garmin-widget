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
        dc.clear();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        dc.drawText(dc.getWidth() / 2, 20, Graphics.FONT_TINY, station.name, Graphics.TEXT_JUSTIFY_CENTER);

        var y = 60;
        var lineHeight = 40;

        if(!departures.size().equals(0)){
            _listComponent = new DepartureListComponent(_model.getDepartures());
        }

        if (_listComponent != null) {
            _listComponent.draw(dc);
        }
        
        if(_model.isFetching){
            dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_TINY, "LADDAR...", Graphics.TEXT_JUSTIFY_CENTER);
            return;
        }
       /* for (var i = 0; i < departures.size(); i += 1) {   
            dc.drawText(dc.getWidth() / 2, y + i * lineHeight, Graphics.FONT_TINY, departures[i].destination + " ("+ departures[i].display + ")", Graphics.TEXT_JUSTIFY_CENTER);
        } */
    }


}
