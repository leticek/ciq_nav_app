using Toybox.System;
using Toybox.WatchUi;
using Toybox.Graphics;

class RouteView extends WatchUi.View {

    hidden var coordinates;
    
    function initialize(){
        View.initialize();
        System.println("route init");
    }

    function setCoords(coords){
        self.coordinates = coords;
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
        
        
        //dc.drawLine(0,114, 218,114);
        
        if(coordinates instanceof Array && coordinates != null){
            for(var i = 0; i < coordinates.size(); i++){
                dc.fillRoundedRectangle(coordinates[i][1], coordinates[i][0], 2, 2, 1.5);
                if(i != coordinates.size() - 1){
                    dc.drawLine(coordinates[i][1], coordinates[i][0], coordinates[i + 1][1], coordinates[i + 1][0]);
                }
            }
        }
    }
    
    function onHide() {
    	System.println("route hide");
    }
    
    
    function moveUp(zoom){
    	for(var i = 0; i < coordinates.size(); i++){
    		coordinates[i][0] -= 3 * (zoom * 1.8);
    	}
    	self.requestUpdate();
    }
    
    function moveDown(zoom){
    	for(var i = 0; i < coordinates.size(); i++){
    		coordinates[i][0] += 3 * (zoom * 1.8);
    	}
    	self.requestUpdate();
    }
    
    function moveLeft(zoom){
    	for(var i = 0; i < coordinates.size(); i++){
    		coordinates[i][1] -= 3 * (zoom * 1.8);
    	}
    	self.requestUpdate();
    }
    
    function moveRight(zoom){
    	for(var i = 0; i < coordinates.size(); i++){
    		coordinates[i][1] += 3 * (zoom * 1.8);
    	}
    	self.requestUpdate();
    }
    
    function zoom(zoom){
    	Application.getApp().calculateZoom(zoom);
    	self.requestUpdate();
    }
    
    
    
}