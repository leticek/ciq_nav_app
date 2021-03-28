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
    (:round218)
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

    (:round240)
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

    (:round260)
    function onUpdate(dc) {
        View.onUpdate(dc);
        System.println("loadView update");
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.clear();  
        dc.drawText(130, 70, 10, "Nahrajte trasu z telefonu", Graphics.TEXT_JUSTIFY_CENTER);
        for(var i = 0; i < Application.getApp().dataCounter; i++){
            dc.fillCircle(81 + (i * 29), 135, 17);
            
        }
        if(!Application.getApp().gpsReady){
            dc.drawText(125, 185, 10, "Čekám na GPS", Graphics.TEXT_JUSTIFY_CENTER);
        }
        else{
            dc.drawText(125, 185, 10, "GPS připravena", Graphics.TEXT_JUSTIFY_CENTER);
        }
        if(Application.getApp().gpsReady && Application.getApp().dataCounter == 3){
            Application.getApp().canStartNavigation = true;
            dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_WHITE);
            dc.fillCircle(215, 65, 15);
        }
    }

    (:round280)
    function onUpdate(dc) {
        View.onUpdate(dc);
        System.println("loadView update");
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.clear();  
        dc.drawText(140, 75, 10, "Nahrajte trasu z telefonu", Graphics.TEXT_JUSTIFY_CENTER);
        for(var i = 0; i < Application.getApp().dataCounter; i++){
            dc.fillCircle(88 + (i * 53), 145, 15);
        }
        if(!Application.getApp().gpsReady){
            dc.drawText(135, 198, 10, "Čekám na GPS", Graphics.TEXT_JUSTIFY_CENTER);
        }
        else{
            dc.drawText(135, 198, 10, "GPS připravena", Graphics.TEXT_JUSTIFY_CENTER);
        }
        if(Application.getApp().gpsReady && Application.getApp().dataCounter == 3){
            Application.getApp().canStartNavigation = true;
            dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_WHITE);
            dc.fillCircle(215, 65, 15);
        }
    }

    (:rectangle240)
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


    // onHide() is called when this View is removed from the screen
    function onHide() {
    }
}