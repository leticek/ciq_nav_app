using Toybox.WatchUi;
using Toybox.Graphics;

class LoadView extends WatchUi.View {
    function initialize() {
        View.initialize();
    }

    // Resources are loaded here
    function onLayout(dc) {
        
    }

    // onShow() is called when this View is brought to the foreground
    function onShow() {
    }

    // onUpdate() is called periodically to update the View
    function onUpdate(dc) {
        System.println("loadView update");
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.clear();  
        dc.drawText(110, 55, 10, "Nahrajte trasu z telefonu", Graphics.TEXT_JUSTIFY_CENTER);
        for(var i = 0; i < Application.getApp().dataCounter; i++){
            dc.fillCircle(65 + (i * 45), 115, 15);
        }
        if(!Application.getApp().gpsReady){
            dc.drawText(110, 155, 10, "Čekám na GPS", Graphics.TEXT_JUSTIFY_CENTER);
        }
        else{
            dc.drawText(110, 155, 10, "GPS připravena", Graphics.TEXT_JUSTIFY_CENTER);
        }
        //View.onUpdate(dc);
    }

    // onHide() is called when this View is removed from the screen
    function onHide() {
    }
}