using Toybox.System;
using Toybox.WatchUi;
using Toybox.Graphics;

class RouteView extends WatchUi.View {

    hidden var coordinates;
<<<<<<< HEAD
    hidden var zoomLevel = 1;
    hidden var userPosition;
=======
>>>>>>> efb6c3b1a7a57504a9532caf5ce3b6b6c4f813b4
    
    function initialize(){
        View.initialize();
        System.println("route init");
    }

    function setCoords(coords){
        self.coordinates = coords;
        self.requestUpdate();
    }
<<<<<<< HEAD
    
    function setUserPosition(coords){
        self.userPosition = coords;
        self.requestUpdate();
    }
=======
>>>>>>> efb6c3b1a7a57504a9532caf5ce3b6b6c4f813b4

    function onLayout(dc){

    } 
    
    function onShow(){
        WatchUi.requestUpdate();
    }
    
    function onUpdate(dc){
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.clear();
         
        System.println("Vyska: " + dc.getHeight() + " Sirka: " + dc.getWidth());
        
        dc.drawLine(55, 0,55, 218);
        dc.drawLine(165, 0,165, 218);
        
        dc.drawLine(0, 55, 218, 55);
        dc.drawLine(0, 165, 218, 165);
<<<<<<< HEAD
                
        dc.drawBitmap(18, 100, WatchUi.loadResource(Rez.Drawables.leftArrow));
        dc.drawBitmap(182, 100, WatchUi.loadResource(Rez.Drawables.rightArrow));
        dc.drawBitmap(98, 18, WatchUi.loadResource(Rez.Drawables.upArrow));
        dc.drawBitmap(98, 182, WatchUi.loadResource(Rez.Drawables.downArrow));
=======
        
        
        //dc.drawLine(0,114, 218,114);
        
>>>>>>> efb6c3b1a7a57504a9532caf5ce3b6b6c4f813b4
        if(coordinates instanceof Array && coordinates != null){
            for(var i = 0; i < coordinates.size(); i++){
                dc.fillRoundedRectangle(coordinates[i][1], coordinates[i][0], 2, 2, 1.5);
                if(i != coordinates.size() - 1){
                    dc.drawLine(coordinates[i][1], coordinates[i][0], coordinates[i + 1][1], coordinates[i + 1][0]);
                }
            }
        }
<<<<<<< HEAD
        
        dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_WHITE); 
        if(userPosition instanceof Array && userPosition != null){
        	dc.fillRoundedRectangle(userPosition[1], userPosition[0], 3, 3, 2);
        }
=======
>>>>>>> efb6c3b1a7a57504a9532caf5ce3b6b6c4f813b4
    }
    
    function onHide() {
    	System.println("route hide");
    }
    
    
<<<<<<< HEAD
    function moveUp(){
    	for(var i = 0; i < coordinates.size(); i++){
    		coordinates[i][0] -= 3 * (zoomLevel * 1.8);
=======
    function moveUp(zoom){
    	for(var i = 0; i < coordinates.size(); i++){
    		coordinates[i][0] -= 3 * (zoom * 1.8);
>>>>>>> efb6c3b1a7a57504a9532caf5ce3b6b6c4f813b4
    	}
    	self.requestUpdate();
    }
    
<<<<<<< HEAD
    function moveDown(){
    	for(var i = 0; i < coordinates.size(); i++){
    		coordinates[i][0] += 3 * (zoomLevel * 1.8);
=======
    function moveDown(zoom){
    	for(var i = 0; i < coordinates.size(); i++){
    		coordinates[i][0] += 3 * (zoom * 1.8);
>>>>>>> efb6c3b1a7a57504a9532caf5ce3b6b6c4f813b4
    	}
    	self.requestUpdate();
    }
    
<<<<<<< HEAD
    function moveLeft(){
    	for(var i = 0; i < coordinates.size(); i++){
    		coordinates[i][1] -= 3 * (zoomLevel * 1.8);
=======
    function moveLeft(zoom){
    	for(var i = 0; i < coordinates.size(); i++){
    		coordinates[i][1] -= 3 * (zoom * 1.8);
>>>>>>> efb6c3b1a7a57504a9532caf5ce3b6b6c4f813b4
    	}
    	self.requestUpdate();
    }
    
<<<<<<< HEAD
    function moveRight(){
    	for(var i = 0; i < coordinates.size(); i++){
    		coordinates[i][1] += 3 * (zoomLevel * 1.8);
=======
    function moveRight(zoom){
    	for(var i = 0; i < coordinates.size(); i++){
    		coordinates[i][1] += 3 * (zoom * 1.8);
>>>>>>> efb6c3b1a7a57504a9532caf5ce3b6b6c4f813b4
    	}
    	self.requestUpdate();
    }
    
<<<<<<< HEAD
    function zoom(zoomMode){
    	if(coordinates != null){
    		if(zoomMode){
    			zoomLevel += 0.2;
    			Application.getApp().calculateZoom(zoomLevel);
    		}
    	
    		else{
    			zoomLevel -= 0.2;
    			Application.getApp().calculateZoom(zoomLevel);
    		}
    	}
=======
    function zoom(zoom){
    	Application.getApp().calculateZoom(zoom);
>>>>>>> efb6c3b1a7a57504a9532caf5ce3b6b6c4f813b4
    	self.requestUpdate();
    }
    
    
    
}