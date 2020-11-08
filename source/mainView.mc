using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Communications;
using Toybox.Position;
using Toybox.Math;
using Toybox.Lang;
using Toybox.Time.Gregorian as Calendar;


class MainView extends WatchUi.View {

	hidden var routeStepList;
	hidden var routePointsList;
	hidden var instruction = "-";
	hidden var currStep = 0;
	hidden var lastKnownPosition;
	hidden var distance = 0;
	hidden var isFirst = true;
	hidden var directionImage = null;
	hidden var totalDistance = 0;
	
	function onPosition(posInfo){
		var now = Time.now();
		var time = Calendar.info(now, Time.FORMAT_SHORT);
		var str = time.hour + ":" + time.min + ":" + time.sec;
		System.println(str);
	try{
		var currPosition = posInfo.position;
		if(isFirst){
			System.println("routeStepList access");
			distance = routeStepList[currStep].distance;
			System.println("routeStepList access -- ok");
			lastKnownPosition = currPosition;
			isFirst = false;
		} else{
			var traveledDistance = distanceBetweenTwoPoints(lastKnownPosition, currPosition);
			totalDistance += traveledDistance;
			var currDistance = distance - traveledDistance;
			System.println(currDistance);
			if(currDistance < 4){
				System.println(currStep);
				if(currStep < routeStepList.size() - 1){
					currStep += 1;
					currDistance = routeStepList[currStep].distance;
				}
			}
			lastKnownPosition = currPosition;
			distance = currDistance;
		}
		System.println(routeStepList[currStep].instructionType);
		switch(routeStepList[currStep].instructionType){
			case 0:
				directionImage = WatchUi.loadResource(Rez.Drawables.left);
				break;
			case 1:
				directionImage = WatchUi.loadResource(Rez.Drawables.right);
				break;
			case 2:
				directionImage = WatchUi.loadResource(Rez.Drawables.sharpLeft);
				break;
			case 3:
				directionImage = WatchUi.loadResource(Rez.Drawables.sharpRight);
				break;
			case 4:
				directionImage = WatchUi.loadResource(Rez.Drawables.slightLeft);
				break;
			case 5:
				directionImage = WatchUi.loadResource(Rez.Drawables.slightRight);
				break;
			case 6:
				directionImage = WatchUi.loadResource(Rez.Drawables.straight);
				break;
			case 9:
				directionImage = WatchUi.loadResource(Rez.Drawables.uTurn);
				break;
			case 10:
				directionImage = WatchUi.loadResource(Rez.Drawables.goal);
				break;
			case 11:
				directionImage = WatchUi.loadResource(Rez.Drawables.depart);
				break;
			default:
				directionImage = WatchUi.loadResource(Rez.Drawables.depart);
				break;
		}
		instruction = routeStepList[currStep].stepInstruction;
		Communications.transmit(currPosition.toDegrees(), null, new MyConnectionListener());
		WatchUi.requestUpdate();
		}
		catch(ex){
		System.println(ex.getErrorMessage());
		}
	}
	
	function startNavigate(){
		Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPosition));
	}

    function initialize() {
    	startNavigate();
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
		WatchUi.requestUpdate();
    }

    // Update the view
    function onUpdate(dc) {
  		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
    	dc.clear();
    	if(directionImage != null){
    		dc.drawBitmap(dc.getWidth() / 2.5, 30, directionImage);
    	}
    	dc.drawText(dc.getWidth() / 2, 120, 9, instruction , Graphics.TEXT_JUSTIFY_CENTER);
    	dc.drawText(dc.getWidth() / 1.88, 160, 10, "Distance: " + distance.toNumber() +"m", Graphics.TEXT_JUSTIFY_CENTER);  
    	dc.drawText(dc.getWidth() / 1.88, 190, 9, "Total: " + totalDistance.toNumber() +"m", Graphics.TEXT_JUSTIFY_CENTER);   
    	 
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
    function distanceBetweenTwoPoints(startPoint, endPoint) {
    var startInRads = startPoint.toRadians();
    var endInRads = endPoint.toRadians();
    var startInDegs = startPoint.toDegrees();
    var endInDegs = endPoint.toDegrees();
    var theta = startInDegs[1] - endInDegs[1];
    var dist = Math.sin(startInRads[0]) * Math.sin(endInRads[0]) + Math.cos(startInRads[0]) * Math.cos(endInRads[0]) * Math.cos(deg2rad(theta));
    dist = Math.acos(dist);
    dist = rad2deg(dist);
    dist = dist * 60 * 1.1515;
    dist = (dist * 1.609344) * 1000;
    return dist;
  }
  
  function deg2rad(deg){ 
  	return (deg * Math.PI / 180.0);
  }

  function rad2deg(rad){ 
  	return (rad * 180.0 / Math.PI);
  }
  
  class MyConnectionListener extends Communications.ConnectionListener{
  	function initialize(){
  		ConnectionListener.initialize();
  	}
	function onComplete(){}
	function onError(){}
}

}


