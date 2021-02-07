using Toybox.Application;
using Toybox.Position;
using Toybox.Communications;
using Toybox.WatchUi;
using Toybox.System;
using Toybox.Math;

class NavApp extends Application.AppBase {

	private var routeView;
    private var mainView;

    
	hidden var routeSteps;
    hidden var wayPoints;
    hidden var boundingBox;
    hidden var latLongToPixels;
	hidden var radius = 6371;
	
    function initialize() {
        AppBase.initialize();
        Communications.registerForPhoneAppMessages(method(:messageReceived));
    }

    // onStart() is called on application start up
    function onStart(state) {
		self.routeView = new RouteView();
        self.mainView = new MainView();
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ self.mainView, new MainViewBehaviorDelegate() ];
    }

    function messageReceived(message){
		if(message.data["type"].toString().equals("routeSteps")){
			try{
				routeSteps = parseRouteSteps(message);
				System.println("routeSteps parsed");
			}
			catch(ex){
				System.println(ex.getErrorMessage());
			}	
		}
		if(message.data["type"].toString().equals("routePoints")){
			try{
				wayPoints = parseWayPoints(message);
				System.println("wayPoints parsed");
			}
			catch(ex){
				System.println(ex.getErrorMessage());
			}
		}
        if(message.data["type"].toString().equals("boundingBox")){
			
			boundingBox = new [2];
            boundingBox[0] = new Position.Location({
												 :latitude => message.data["data"][1],
        										 :longitude => message.data["data"][0],
        										 :format => :degrees});
            boundingBox[1] = new Position.Location({
												 :latitude => message.data["data"][3],
        										 :longitude => message.data["data"][2],
        										 :format => :degrees});
            latLongToPixels = new [wayPoints.size()];
            
            
            var topLeft = new MyReferencePoint(26, 36, boundingBox[1].toDegrees()[0],  boundingBox[1].toDegrees()[1]);
            var bottomRight = new MyReferencePoint(191, 181, boundingBox[0].toDegrees()[0],  boundingBox[0].toDegrees()[1]);
            topLeft.setGlobalXY(latlngToGlobalXY(topLeft.latitude, topLeft.longitude, topLeft, bottomRight));
            bottomRight.setGlobalXY(latlngToGlobalXY(bottomRight.latitude, bottomRight.longitude, topLeft, bottomRight));
            
            for(var i = 0; i < wayPoints.size(); i++){
                System.println("Pozice: " + i + " Lat: " + wayPoints[i].toDegrees()[1] + " Lon: " + wayPoints[i].toDegrees()[0]);
                latLongToPixels[i] = latlngToScreenXY(wayPoints[i].toDegrees()[0], wayPoints[i].toDegrees()[1], topLeft, bottomRight);
                System.println("Pozice: " + i + " X: " + latLongToPixels[i][0] + " Y: " + latLongToPixels[i][1]);
            }
            routeView.setCoords(latLongToPixels);
            routeView.onShow();
            System.println("bb ok");
		}
	}

	function parseRouteSteps(receivedMessage){
		var parsedRouteSteps = new [receivedMessage.data["data"].size()];
		for(var i = 0; i < parsedRouteSteps.size(); i++){ 
			parsedRouteSteps[i] = new RouteStep(receivedMessage.data["data"][i]["passed"],
											receivedMessage.data["data"][i]["instruction"],
											receivedMessage.data["data"][i]["type"],
											new Position.Location({
												:latitude => receivedMessage.data["data"][i]["startPoint"]["latitude"],
        										:longitude => receivedMessage.data["data"][i]["startPoint"]["longitude"],
        										:format => :degrees}),
											new Position.Location({
												:latitude => receivedMessage.data["data"][i]["endPoint"]["latitude"],
        										:longitude => receivedMessage.data["data"][i]["endPoint"]["longitude"],
        										:format => :degrees}), 
        									receivedMessage.data["data"][i]["startWayPoint"],
        									receivedMessage.data["data"][i]["finishWayPoint"],
        									receivedMessage.data["data"][i]["distance"]);
			}
		return parsedRouteSteps;
	}

	function parseWayPoints(receivedMessage){
		var parsedWayPoints = new [receivedMessage.data["data"].size()];
		for(var i = 0; i < parsedWayPoints.size(); i++){
			parsedWayPoints[i] = new Position.Location({
												:latitude => receivedMessage.data["data"][i]["latitude"],
        										:longitude => receivedMessage.data["data"][i]["longitude"],
        										:format => :degrees});
			}
		return parsedWayPoints;
	}
	
	function latlngToGlobalXY(lat, lng, p0, p1){
    	var x = radius * lng * Math.cos((p0.latitude + p1.latitude) / 2);
    	var y = radius * lat;
    	return [x, y];
	}
	
	function latlngToScreenXY(lat, lng, p0, p1){
    	var pos = new MyPoint(latlngToGlobalXY(lat, lng, p0, p1));
    	pos.percentageX = ((165) / (p1.globalXY[0] - p0.globalXY[0]));
    	pos.percentageY = ((145) / (p1.globalXY[1] - p0.globalXY[1]));
    	return [
        218 - (p0.screenY + (p1.globalXY[1] - pos.position[1]) * pos.percentageX),
        218 - (p0.screenX + (pos.position[0] - p0.globalXY[0]) * pos.percentageX)
    	];
	}

}
