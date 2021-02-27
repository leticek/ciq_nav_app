using Toybox.System;
using Toybox.WatchUi;
using Toybox.Graphics;

class RouteView extends WatchUi.View {

    hidden var coordinates;
    hidden var zoomLevel = 1;
    hidden var userPosition;
    
    function initialize(){
        View.initialize();
        System.println("route init");
    }

    function setCoords(coords){
        self.coordinates = coords;
        self.requestUpdate();
    }
    
    function setUserPosition(coords){
        self.userPosition = coords;
        self.requestUpdate();
    }

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
                
        dc.drawBitmap(18, 100, WatchUi.loadResource(Rez.Drawables.leftArrow));
        dc.drawBitmap(182, 100, WatchUi.loadResource(Rez.Drawables.rightArrow));
        dc.drawBitmap(98, 18, WatchUi.loadResource(Rez.Drawables.upArrow));
        dc.drawBitmap(98, 182, WatchUi.loadResource(Rez.Drawables.downArrow));
        if(coordinates instanceof Array && coordinates != null){
            for(var i = 0; i < coordinates.size(); i++){
                dc.fillRoundedRectangle(coordinates[i][1], coordinates[i][0], 2, 2, 1.5);
                if(i != coordinates.size() - 1){
                    dc.drawLine(coordinates[i][1], coordinates[i][0], coordinates[i + 1][1], coordinates[i + 1][0]);
                }
            }
        }
        
        dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_WHITE); 
        if(userPosition instanceof Array && userPosition != null){
        	dc.fillRoundedRectangle(userPosition[1], userPosition[0], 3, 3, 2);
        }
    }
    
    function onHide() {
    	System.println("route hide");
    }
    
    
    function moveUp(){
    	for(var i = 0; i < coordinates.size(); i++){
    		coordinates[i][0] -= 3 * (zoomLevel * 1.8);
    	}
    	self.requestUpdate();
    }
    
    function moveDown(){
    	for(var i = 0; i < coordinates.size(); i++){
    		coordinates[i][0] += 3 * (zoomLevel * 1.8);
    	}
    	self.requestUpdate();
    }
    
    function moveLeft(){
    	for(var i = 0; i < coordinates.size(); i++){
    		coordinates[i][1] -= 3 * (zoomLevel * 1.8);
    	}
    	self.requestUpdate();
    }
    
    function moveRight(){
    	for(var i = 0; i < coordinates.size(); i++){
    		coordinates[i][1] += 3 * (zoomLevel * 1.8);
    	}
    	self.requestUpdate();
    }
    
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
    	self.requestUpdate();
    }
    
    
    
}