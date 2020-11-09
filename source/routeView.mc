using Toybox.System;
using Toybox.WatchUi;
using Toybox.Graphics;

class RouteView extends WatchUi.View {

    hidden var coordinates;
    
    function intialize(){
        View.initialize();
    }

    function setCoords(coords){
        self.coordinates = coords;
    }

    

    function onLayout(dc){

    } 
    
    function onShow(){
    	System.println("nechapu");
        WatchUi.requestUpdate();
    }
    
    function onUpdate(dc){
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.clear();
        if(coordinates instanceof Array){
            for(var i = 0; i < coordinates.size(); i++){
            //dc.drawPoint(xyCoords[i][0], xyCoords[i][1]);
                dc.fillRoundedRectangle(coordinates[i][1] + 20, coordinates[i][0] + 10, 1, 1, 0.5);
                if(i != coordinates.size() - 1){
                    dc.drawLine(coordinates[i][1] + 20, coordinates[i][0] + 10, coordinates[i + 1][1] + 20, coordinates[i + 1][0] + 10);
                }
            }
        }
        drawDial(dc);
        //dc.drawText(dc.getWidth() / 2, 120, 9, "instruction" , Graphics.TEXT_JUSTIFY_CENTER);
    }
    
        hidden function drawDial(dc) {
        var centerX = dc.getWidth() / 2;
        var centerY = dc.getHeight() / 2;
        var radius = centerX > centerY ? centerY : centerX;
        var oedge = radius + 1;
        var radians = Math.PI / 4.0; // * 2.0 / 96.0

        //dc.setColor(Graphics.COLOR_WHITE, Gfx.COLOR_WHITE);
        for (var i = 0, angle = 7; i < 1; i += 1) {
            var iedge, cos, sin, x1, y1, x2, y2;

            if (i % 4 == 0) { // Hours
                dc.setPenWidth(3);
                // Longer dashes every 3 hours
                iedge = oedge - ((i % 12 == 0) ? 10 : 5);
            }
            else { // Minutes
                dc.setPenWidth(1);
                iedge = oedge - 5;
            }

            cos = Math.cos(angle);
            sin = Math.sin(angle);

            x1 = cos * iedge;
            y1 = sin * iedge;
            x2 = cos * oedge;
            y2 = sin * oedge;

			System.println("x1: " + x1 + " y1: " + y1 +" x2: " + x2 + " y2: " + y2);
			
			var rightDown = [centerX + x2, centerY + y2];
			var rightTop = [centerX + x2, centerY - y2];
			var leftTop = [centerX - x2, centerY - y2];
			var leftDown = [centerX - x2, centerY + y2];
			System.println("RD" + rightDown);
			System.println("RT" + rightTop);
			System.println("LT" + leftTop);
			System.println("LD" + leftDown);
			
        
            angle += radians;
        }
    }

    function onHide(){

    }
}