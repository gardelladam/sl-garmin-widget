import Toybox.Graphics;
import Toybox.WatchUi;

class StartView extends WatchUi.View {
    private var icon;
    private var appName;

    function initialize() {
        View.initialize();
        icon = WatchUi.loadResource(Rez.Drawables.IconWidget);
        appName = WatchUi.loadResource(Rez.Strings.AppName);
    }

    function onUpdate(dc as Dc) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();

        drawIcon(dc);
        drawText(dc);
    }

    function drawIcon(dc as Dc) {
        if (icon != null) {
            var iconWidth = icon.getWidth();
            var iconHeight = icon.getHeight();
            var x = (dc.getWidth() - iconWidth) / 2;
            var y = dc.getHeight() / 3 - iconHeight / 2;
            dc.drawBitmap(x, y, icon);
        }
    }

    function drawText(dc as Dc) {
        dc.drawText(
            dc.getWidth() / 2,
            dc.getHeight() / 2,
            Graphics.FONT_LARGE,
            appName,
            Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_CENTER
        );
    }
}
