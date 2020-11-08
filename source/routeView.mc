using Toybox.Application;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Math;
using Toybox.Lang;

class RouteView extends WatchUi.View {

    hidden var coordinates;

    function intialize(coords){
        self.coordinates = coords;
        View.initialize();
    }

    function onLayout(dc){

    } 
    
    function onShow(){
        WatchUi.requestUpdate();
    }
    
    function onUpdate(dc){
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.clear();
        for(var i = 0; i < coordinates.size(); i++){
            //dc.drawPoint(xyCoords[i][0], xyCoords[i][1]);
            dc.fillRoundedRectangle(coordinates[i][1] + 25, coordinates[i][0] + 10, 1, 1, 0.5);
            if(i != coordinates.size() - 1){
                dc.drawLine(coordinates[i][1] + 25, coordinates[i][0] + 10, coordinates[i + 1][1] + 25, coordinates[i + 1][0] + 10);
            }
        }
        
        //dc.drawText(dc.getWidth() / 2, 120, 9, "instruction" , Graphics.TEXT_JUSTIFY_CENTER);
    }

    function onHide(){

    }
}