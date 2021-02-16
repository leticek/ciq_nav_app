using Toybox.WatchUi;

class MainViewBehaviorDelegate extends WatchUi.BehaviorDelegate {

	hidden var currentScreen = 0;
	hidden var routeView;
	hidden var mainView;
	hidden var zoom = 1;
	hidden var zoomMode = true;

    function initialize(mainView, routeView) {
        BehaviorDelegate.initialize();
        self.mainView = mainView;
        self.routeView = routeView;
    }   
    
    function onNextPage(){
    	System.print("swipe up");
    	if(currentScreen == 0){
			currentScreen = 1;
    		Toybox.WatchUi.switchToView(self.routeView, self, SLIDE_DOWN);    		    	
    		}
    	return true;
    }
    
    function onPreviousPage(){
    	System.print("swipe down");
    	if(currentScreen == 1){
    		currentScreen = 0;
    		Toybox.WatchUi.switchToView(self.mainView, self, SLIDE_DOWN);
    	}
    	return true;
    } 

	
    
   		/*dc.drawLine(55, 0,55, 218);
        dc.drawLine(165, 0,165, 218);
        
        dc.drawLine(0, 55, 218, 55);
        dc.drawLine(0, 165, 218, 165);*/
    
    
    
    function onTap(clickEvent) {
    	if(currentScreen == 1){
    		var xTapped = clickEvent.getCoordinates()[0];
    		var yTapped = clickEvent.getCoordinates()[1];
	        if(xTapped >= 55 && xTapped <= 165 && yTapped <= 55){
        		self.routeView.moveUp(zoom);
        	}
        	else if(xTapped >= 55 && xTapped <= 165 && yTapped >= 165){
        		self.routeView.moveDown(zoom);
        	}
        	else if(xTapped <= 55 && yTapped >= 55  && yTapped <= 165){
        		self.routeView.moveLeft(zoom);
        	}
        	else if(xTapped >= 165 && yTapped >= 55  && yTapped <= 165){
	        	self.routeView.moveRight(zoom);
        	}
        	else{
        		if(zoomMode){
        			zoom += 0.2;        	
        		}
        		else{
        			zoom -= 0.2;
        		}
        		self.routeView.zoom(zoom);
        	}
       	}
        return true;
    }
    
    function onSwipe(swipeEvent){
    	if(swipeEvent.getDirection() == 1){
    		zoomMode = !zoomMode;
    	}
    	return true;
    }
    
    
}