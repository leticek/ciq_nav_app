using Toybox.WatchUi;

class LoadViewBehaviorDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onKey(keyEvent){
        System.println(keyEvent.getKey());
        if(Application.getApp().canStartNavigation && keyEvent.getKey() == 4){
            Application.getApp().startNavigation();
        }
        return true;
    }

    function onBack(){
		System.exit();
		return true;
	}
}