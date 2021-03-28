using Toybox.WatchUi;

class MainBehaviorDelegate extends WatchUi.BehaviorDelegate {

	hidden var currentScreen = 0;
	hidden var routeView;
	hidden var mainView;
	hidden var zoomMode = true;

	hidden enum{
		SWITCH_VIEWS,
		UP_DOWN,
		LEFT_RIGHT,
		ZOOM
	}

    function initialize(mainView, routeView) {
        BehaviorDelegate.initialize();
        self.mainView = mainView;
        self.routeView = routeView;
    }   

	function onBack(){
		System.println("exit");
		System.exit();
		return true;
	}

	(:buttons)
	function onKey(keyEvent){
		System.println(keyEvent.getKey());
		switch(keyEvent.getKey()){
			case 13: 
				keyUp();
				break;
			case 8: 
				keyDown();	//keyDown
				break;
			case 4: 
				switchMode();//enter
				break;
			case 7: //menu
				break;
			case 22: //clock
				break;
		}	
	}

	(:buttons)
	function switchMode(){
		if(self.routeView.currentMode < 3){
			self.routeView.currentMode += 1;
		}
		else{
			self.routeView.currentMode = 0;
		}
		self.routeView.requestUpdate();
	}

	(:buttons)
	function keyUp(){
		switch(self.routeView.currentMode){
			case SWITCH_VIEWS:
				if(currentScreen == 1){
    				currentScreen = 0;
    				Toybox.WatchUi.switchToView(self.mainView, self, SLIDE_UP);
    			}
				break;
			case UP_DOWN:
				self.routeView.moveUp();
				break;
			case LEFT_RIGHT:
				self.routeView.moveLeft();
				break;
			case ZOOM:
				self.routeView.zoom(true);
				break;
		}
	}

	(:buttons)
	function keyDown(){
		switch(self.routeView.currentMode){
			case SWITCH_VIEWS:
				if(currentScreen == 0){
					currentScreen = 1;
    				Toybox.WatchUi.switchToView(self.routeView, self, SLIDE_DOWN);    		    	
    			}
				break;
			case UP_DOWN:
				self.routeView.moveDown();
				break;
			case LEFT_RIGHT:
				self.routeView.moveRight();
				break;
			case ZOOM:
				self.routeView.zoom(false);
				break;
		}
	}


    (:touch)
    function onNextPage(){
    	System.print("swipe up");
    	if(currentScreen == 0){
			currentScreen = 1;
    		Toybox.WatchUi.switchToView(self.routeView, self, SLIDE_DOWN);    		    	
    	}
    	return true;
    }
    
	(:touch)
    function onPreviousPage(){
    	System.print("swipe down");
    	if(currentScreen == 1){
    		currentScreen = 0;
    		Toybox.WatchUi.switchToView(self.mainView, self, SLIDE_UP);
    	}
    	return true;
    }   
    
	(:touch218)
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

	(:touch240)
    function onTap(clickEvent) {
    	if(currentScreen == 1){
    		var xTapped = clickEvent.getCoordinates()[0];
    		var yTapped = clickEvent.getCoordinates()[1];
	        if(xTapped >= 25 && xTapped <= 215 && yTapped <= 50){
        		self.routeView.moveUp();
        	}
        	else if(xTapped >= 25 && xTapped <= 215 && yTapped >= 200){
        		self.routeView.moveDown();
        	}
        	else if(xTapped <= 55 && yTapped >= 35  && yTapped <= 210){
        		self.routeView.moveLeft();
        	}
        	else if(xTapped >= 200 && yTapped >= 35  && yTapped <= 210){
	        	self.routeView.moveRight();
        	}
        	else{
        		self.routeView.zoom(zoomMode);
        	}
       	}
        return true;
    }

	//TODO: fix this
	(:touch260)
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
    
	(:touch)
    function onSwipe(swipeEvent){
		if(swipeEvent.getDirection() == 3){
    		zoomMode = !zoomMode;
    	}
    	return true;
    }
}