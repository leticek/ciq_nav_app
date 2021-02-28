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
    (:vivoactive4s)
    function onUpdate(dc) {
        View.onUpdate(dc);
        System.println("loadView update");
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.clear();  
        dc.drawText(110, 60, 10, "Nahrajte trasu z telefonu", Graphics.TEXT_JUSTIFY_CENTER);
        for(var i = 0; i < Application.getApp().dataCounter; i++){
            dc.fillCircle(65 + (i * 45), 120, 15);
        }
        if(!Application.getApp().gpsReady){
            dc.drawText(110, 160, 10, "Čekám na GPS", Graphics.TEXT_JUSTIFY_CENTER);
        }
        else{
            dc.drawText(110, 160, 10, "GPS připravena", Graphics.TEXT_JUSTIFY_CENTER);
        }
        if(Application.getApp().gpsReady && Application.getApp().dataCounter == 3){
            Application.getApp().canStartNavigation = true;
            dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_WHITE);
            dc.fillCircle(195, 65, 15);
        }
    }

    (:venusq)
    function onUpdate(dc) {
        View.onUpdate(dc);
        System.println("loadView update");
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.clear();  
        dc.drawText(120, 55, 10, "Nahrajte trasu z telefonu", Graphics.TEXT_JUSTIFY_CENTER);
        for(var i = 0; i < Application.getApp().dataCounter; i++){
            dc.fillCircle(75 + (i * 45), 120, 15);
        }
        if(!Application.getApp().gpsReady){
            dc.drawText(120, 160, 10, "Čekám na GPS", Graphics.TEXT_JUSTIFY_CENTER);
        }
        else{
            dc.drawText(120, 160, 10, "GPS připravena", Graphics.TEXT_JUSTIFY_CENTER);
        }
        if(Application.getApp().gpsReady && Application.getApp().dataCounter == 3){
            Application.getApp().canStartNavigation = true;
            dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_WHITE);
            dc.fillCircle(240, 65, 25);
        }
    }

    (:fr645m)
    function onUpdate(dc) {
        View.onUpdate(dc);
        System.println("loadView update");
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.clear();  
        dc.drawText(120, 65, 10, "Nahrajte trasu z telefonu", Graphics.TEXT_JUSTIFY_CENTER);
        for(var i = 0; i < Application.getApp().dataCounter; i++){
            dc.fillCircle(75 + (i * 45), 125, 15);
        }
        if(!Application.getApp().gpsReady){
            dc.drawText(115, 170, 10, "Čekám na GPS", Graphics.TEXT_JUSTIFY_CENTER);
        }
        else{
            dc.drawText(115, 170, 10, "GPS připravena", Graphics.TEXT_JUSTIFY_CENTER);
        }
        if(Application.getApp().gpsReady && Application.getApp().dataCounter == 3){
            Application.getApp().canStartNavigation = true;
            dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_WHITE);
            dc.fillCircle(215, 65, 15);
        }
    }

    // onHide() is called when this View is removed from the screen
    function onHide() {
    }
}