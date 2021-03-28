using Toybox.System;
using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Lang;

class RouteView extends WatchUi.View {

    hidden var coordinates;
    hidden var zoomLevel = 0.8;
    hidden var isFirst = true;
    hidden var userPosition;
    
    var currentMode = 0;
    
    function initialize(){
        View.initialize();
        System.println("route init");
    }

    function setCoords(coords){
        if(isFirst){
            isFirst = false;
        }
        self.coordinates = coords;
        self.requestUpdate();
    }
    
    function setUserPosition(currentIndex){
        self.userPosition = currentIndex;
        self.requestUpdate();
    }

    function onLayout(dc){

    } 
    
    function onShow(){
        WatchUi.requestUpdate();
    }
    
    (:round218:touch)
    function onUpdate(dc){
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.clear();      
        dc.drawBitmap(18, 100, WatchUi.loadResource(Rez.Drawables.leftArrow));
        dc.drawBitmap(182, 100, WatchUi.loadResource(Rez.Drawables.rightArrow));
        dc.drawBitmap(98, 18, WatchUi.loadResource(Rez.Drawables.upArrow));
        dc.drawBitmap(98, 182, WatchUi.loadResource(Rez.Drawables.downArrow));
        if(coordinates instanceof Array && coordinates != null){
            for(var i = 0; i < coordinates.size(); i++){
                if(userPosition == i){
                    dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_WHITE); 
        	        dc.fillRoundedRectangle(coordinates[i][0], coordinates[i][1], 5, 5, 3);
                    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
                }
                else{
                    dc.fillRoundedRectangle(coordinates[i][0], coordinates[i][1], 2, 2, 1.5);
                }
                if(i != coordinates.size() - 1){
                    dc.drawLine(coordinates[i][0], coordinates[i][1], coordinates[i + 1][0], coordinates[i + 1][1]);
                }
            }
        }
    }

    (:round260:touch)
    function onUpdate(dc){
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.clear();      
        dc.drawBitmap(21, 119, WatchUi.loadResource(Rez.Drawables.leftArrow));
        dc.drawBitmap(217, 119, WatchUi.loadResource(Rez.Drawables.rightArrow));
        dc.drawBitmap(116, 21, WatchUi.loadResource(Rez.Drawables.upArrow));
        dc.drawBitmap(116, 217, WatchUi.loadResource(Rez.Drawables.downArrow));
        if(coordinates instanceof Array && coordinates != null){
            for(var i = 0; i < coordinates.size(); i++){
                if(userPosition == i){
                    dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_WHITE); 
        	        dc.fillRoundedRectangle(coordinates[i][0], coordinates[i][1], 5, 5, 3);
                    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
                }
                else{
                    dc.fillRoundedRectangle(coordinates[i][0], coordinates[i][1], 2, 2, 1.5);
                }
                if(i != coordinates.size() - 1){
                    dc.drawLine(coordinates[i][0], coordinates[i][1], coordinates[i + 1][0], coordinates[i + 1][1]);
                }
            }
        }
    }

    (:rectangle240)
    function onUpdate(dc){
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.clear();      
        dc.drawBitmap(15, 110, WatchUi.loadResource(Rez.Drawables.leftArrow));
        dc.drawBitmap(205, 110, WatchUi.loadResource(Rez.Drawables.rightArrow));
        dc.drawBitmap(110, 15, WatchUi.loadResource(Rez.Drawables.upArrow));
        dc.drawBitmap(110, 205, WatchUi.loadResource(Rez.Drawables.downArrow));
        if(coordinates instanceof Array && coordinates != null){
            for(var i = 0; i < coordinates.size(); i++){
                if(userPosition == i){
                    dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_WHITE); 
        	        dc.fillRoundedRectangle(coordinates[i][0], coordinates[i][1], 5, 5, 3);
                    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
                }
                else{
                    dc.fillRoundedRectangle(coordinates[i][0], coordinates[i][1], 2, 2, 1.5);
                }
                if(i != coordinates.size() - 1){
                    dc.drawLine(coordinates[i][0], coordinates[i][1], coordinates[i + 1][0], coordinates[i + 1][1]);
                }
            }
        }
    }

    (:round240:buttons)
    function onUpdate(dc){
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.clear();
        if(currentMode == 1){      
            dc.drawBitmap(110, 15, WatchUi.loadResource(Rez.Drawables.upArrow));
            dc.drawBitmap(110, 205, WatchUi.loadResource(Rez.Drawables.downArrow));
        }
        else if(currentMode == 2){
            dc.drawBitmap(15, 110, WatchUi.loadResource(Rez.Drawables.leftArrow));
            dc.drawBitmap(205, 110, WatchUi.loadResource(Rez.Drawables.rightArrow));
        }
        else if(currentMode == 3){
            dc.drawBitmap(110, 15, WatchUi.loadResource(Rez.Drawables.plus));
            dc.drawBitmap(110, 205, WatchUi.loadResource(Rez.Drawables.minus));
        }
        if(coordinates instanceof Array && coordinates != null){
            for(var i = 0; i < coordinates.size(); i++){
                if(userPosition == i){
                    dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_WHITE); 
        	        dc.fillRoundedRectangle(coordinates[i][0], coordinates[i][1], 5, 5, 3);
                    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
                }
                else{
                    dc.fillRoundedRectangle(coordinates[i][0], coordinates[i][1], 2, 2, 1.5);
                }
                if(i != coordinates.size() - 1){
                    dc.drawLine(coordinates[i][0], coordinates[i][1], coordinates[i + 1][0], coordinates[i + 1][1]);
                }
            }
        }
    }

    (:round260:buttons)
    function onUpdate(dc){
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.clear();
        if(currentMode == 1){      
            dc.drawBitmap(119, 16, WatchUi.loadResource(Rez.Drawables.upArrow));
            dc.drawBitmap(119, 222, WatchUi.loadResource(Rez.Drawables.downArrow));
        }
        else if(currentMode == 2){
            dc.drawBitmap(16, 119, WatchUi.loadResource(Rez.Drawables.leftArrow));
            dc.drawBitmap(222, 119, WatchUi.loadResource(Rez.Drawables.rightArrow));
        }
        else if(currentMode == 3){
            dc.drawBitmap(119, 16, WatchUi.loadResource(Rez.Drawables.plus));
            dc.drawBitmap(119, 222, WatchUi.loadResource(Rez.Drawables.minus));
        }
        if(coordinates instanceof Array && coordinates != null){
            for(var i = 0; i < coordinates.size(); i++){
                if(userPosition == i){
                    dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_WHITE); 
        	        dc.fillRoundedRectangle(coordinates[i][0], coordinates[i][1], 5, 5, 3);
                    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
                }
                else{
                    dc.fillRoundedRectangle(coordinates[i][0], coordinates[i][1], 2, 2, 1.5);
                }
                if(i != coordinates.size() - 1){
                    dc.drawLine(coordinates[i][0], coordinates[i][1], coordinates[i + 1][0], coordinates[i + 1][1]);
                }
            }
        }
    }

    (:round280:buttons)
    function onUpdate(dc){
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.clear();
        if(currentMode == 1){      
            dc.drawBitmap(128, 18, WatchUi.loadResource(Rez.Drawables.upArrow));
            dc.drawBitmap(128, 239, WatchUi.loadResource(Rez.Drawables.downArrow));
        }
        else if(currentMode == 2){
            dc.drawBitmap(18, 128, WatchUi.loadResource(Rez.Drawables.leftArrow));
            dc.drawBitmap(239, 128, WatchUi.loadResource(Rez.Drawables.rightArrow));
        }
        else if(currentMode == 3){
            dc.drawBitmap(128, 18, WatchUi.loadResource(Rez.Drawables.plus));
            dc.drawBitmap(128, 239, WatchUi.loadResource(Rez.Drawables.minus));
        }
        if(coordinates instanceof Array && coordinates != null){
            for(var i = 0; i < coordinates.size(); i++){
                if(userPosition == i){
                    dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_WHITE); 
        	        dc.fillRoundedRectangle(coordinates[i][0], coordinates[i][1], 5, 5, 3);
                    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
                }
                else{
                    dc.fillRoundedRectangle(coordinates[i][0], coordinates[i][1], 2, 2, 1.5);
                }
                if(i != coordinates.size() - 1){
                    dc.drawLine(coordinates[i][0], coordinates[i][1], coordinates[i + 1][0], coordinates[i + 1][1]);
                }
            }
        }
    }
    
    function onHide() {
    	System.println("route hide");
    }
    
    
    function moveUp(){
        if(coordinates != null){    
    	    for(var i = 0; i < coordinates.size(); i++){
    		    coordinates[i][1] -= 3 * (zoomLevel * 2);
    	    }
    	    self.requestUpdate();
        }
    }
    
    function moveDown(){
        if(coordinates != null){
    	    for(var i = 0; i < coordinates.size(); i++){
    		    coordinates[i][1] += 3 * (zoomLevel * 2);
    	    }
    	    self.requestUpdate();
        }
    }
    
    function moveLeft(){
        if(coordinates != null){
    	    for(var i = 0; i < coordinates.size(); i++){
    		    coordinates[i][0] -= 3 * (zoomLevel * 2);
    	    }
    	    self.requestUpdate();
        }
    }
    
    function moveRight(){
        System.println(Application.getApp().dataCounter);
        if(coordinates != null){
    	    for(var i = 0; i < coordinates.size(); i++){
    		    coordinates[i][0] += 3 * (zoomLevel * 2);
    	    }
    	    self.requestUpdate();
        }
    }
    
    function zoom(zoomMode){
    	if(coordinates != null){
    		if(zoomMode){
    			zoomLevel += 0.1;
    			Application.getApp().calculateZoom(zoomLevel);
    		}
    		else{
    			zoomLevel -= 0.1;
    			Application.getApp().calculateZoom(zoomLevel);
    		}
    	}
    	self.requestUpdate();
    }
}