using Toybox.WatchUi;

class MainBehaviorDelegate extends WatchUi.BehaviorDelegate {

	hidden var currentScreen = 0;
	hidden var routeView;
	hidden var mainView;
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
    		Toybox.WatchUi.switchToView(self.mainView, self, SLIDE_UP);
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
        		self.routeView.moveUp();
        	}
        	else if(xTapped >= 55 && xTapped <= 165 && yTapped >= 165){
        		self.routeView.moveDown();
        	}
        	else if(xTapped <= 55 && yTapped >= 55  && yTapped <= 165){
        		self.routeView.moveLeft();
        	}
        	else if(xTapped >= 165 && yTapped >= 55  && yTapped <= 165){
	        	self.routeView.moveRight();
        	}
        	else{
        		self.routeView.zoom(zoomMode);
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
    
    function onMenu(swipeEvent){
    	
    }
}