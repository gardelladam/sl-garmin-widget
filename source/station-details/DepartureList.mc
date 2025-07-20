using Toybox.Graphics;
using Toybox.Math;
import Toybox.Lang;

function max(a, b) {
    return (a > b) ? a : b;
}

function min(a, b) {
    return (a < b) ? a : b;
}



class DepartureListComponent {
    private var _departures as Array<Departure>;
    private var _scrollOffset = 0;
    private var _lineHeight = 40;
    private var _visibleLines = 0;

    function initialize(departures) {
        _departures = departures;
    }

    function scroll(offset) {
        _scrollOffset += offset;
        _scrollOffset = max(0, _scrollOffset);
        _scrollOffset = min(_scrollOffset, _departures.size() - _visibleLines);

    }

    function draw(dc as Graphics.Dc) {
        var width = dc.getWidth();
        var height = dc.getHeight();

        _visibleLines = height / _lineHeight;

        for (var i = 0; i < _visibleLines && (i + _scrollOffset) < _departures.size(); i += 1) {
            var dep = _departures[i + _scrollOffset];
            var y = 40 + i * _lineHeight;

            // Draw icon placeholder (circle)
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawCircle(20, y + 12, 6);

            // Draw destination
            dc.drawText(40, y, Graphics.FONT_XTINY, dep.destination,Graphics.TEXT_JUSTIFY_CENTER);

            // Draw time (right aligned)
            var timeText = dep.display;
            dc.drawText(width - 10, y, Graphics.FONT_XTINY, timeText, Graphics.TEXT_JUSTIFY_RIGHT);
        }
    }
}
