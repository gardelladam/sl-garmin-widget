using Toybox.Graphics;
using Toybox.Math;
import Toybox.Lang;

class DepartureListComponent {
    private var _lineHeight = 25;
    private var _model as StationDetailsModel;

    function initialize(model as StationDetailsModel) {
        _model = model;
    }

    function draw(dc as Graphics.Dc) {
        var width = dc.getWidth();
        var startY = 70;

        var startIndex = _model.currentPage * _model.pageSize;
        var endIndex = startIndex + _model.pageSize;

        var departures = _model.getDepartures();

        if (endIndex > departures.size()) {
            endIndex = departures.size();
        }

        var departuresToDraw = departures.slice(startIndex, endIndex);

        for (var i = 0; i < departuresToDraw.size(); i += 1) {
            if (_model.currentPage > 0) {
                var arrowX = width / 2;
                var arrowY = startY - _lineHeight / 2;

                var arrowSize = 6;
                dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

                dc.drawLine(
                    arrowX - arrowSize,
                    arrowY + arrowSize / 2,
                    arrowX,
                    arrowY - arrowSize / 2
                );
                dc.drawLine(
                    arrowX + arrowSize,
                    arrowY + arrowSize / 2,
                    arrowX,
                    arrowY - arrowSize / 2
                );
            }
            var dep = departuresToDraw[i];
            var y = startY + i * _lineHeight;

            dc.drawText(
                20,
                y,
                Graphics.FONT_XTINY,
                dep.destination,
                Graphics.TEXT_JUSTIFY_LEFT
            );
            dc.drawText(
                width - 20,
                y,
                Graphics.FONT_XTINY,
                dep.display,
                Graphics.TEXT_JUSTIFY_RIGHT
            );
        }

        var hasMore = endIndex < departures.size();
        if (hasMore) {
            var arrowX = width / 2;
            var arrowY =
                startY +
                departuresToDraw.size() * _lineHeight +
                _lineHeight / 2;

            var arrowSize = 6;
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
            dc.drawLine(
                arrowX - arrowSize,
                arrowY - arrowSize / 2,
                arrowX,
                arrowY + arrowSize / 2
            );
            dc.drawLine(
                arrowX + arrowSize,
                arrowY - arrowSize / 2,
                arrowX,
                arrowY + arrowSize / 2
            );
        }
    }
}
