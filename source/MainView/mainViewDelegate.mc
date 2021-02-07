using Toybox.WatchUi;

class MainViewBehaviorDelegate extends WatchUi.BehaviorDelegate {

	hidden var currentScreen = 0;

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onBack(){
    	System.println("back");
    	var view = new RouteView();
    	if(currentScreen){
    		currentScreen = !currentScreen;
    		Toybox.WatchUi.switchToView(new RouteView(), self, SLIDE_DOWN);
    	}
    	else{
    		currentScreen = !currentScreen;
    		Toybox.WatchUi.switchToView(new MainView(), self, SLIDE_DOWN);
    		}
    	return true;
    }
    
    function onNextPage(){
    	System.print("swipe up");
    	if(currentScreen == 0){
			currentScreen = 1;
    		Toybox.WatchUi.switchToView(new RouteView(), self, SLIDE_DOWN);    		    	
    		}
    	return true;
    }
    
    
    function onPreviousPage(){
    	System.print("swipe down");
    	if(currentScreen == 1){
    		currentScreen = 0;
    		Toybox.WatchUi.switchToView(new MainView(), self, SLIDE_DOWN);
    	}
    	return true;
    }
    
}