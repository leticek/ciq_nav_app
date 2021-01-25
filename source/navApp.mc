using Toybox.Application;
using Toybox.Position;
using Toybox.Communications;
using Toybox.WatchUi;
using Toybox.System;

class NavApp extends Application.AppBase {

    hidden var routeSteps;
    hidden var wayPoints;
    hidden var boundingBox;
    hidden var latLongToPixels;
    hidden var routeView;
<<<<<<< HEAD
    hidden var mainView;
=======
>>>>>>> 467900165ee1dcbb4ae9a7999b010a751fcc5dc1
	hidden var deviceInfo;
	
    function initialize() {
    	deviceInfo = System.getDeviceSettings();
        Communications.registerForPhoneAppMessages(method(:messageReceived));
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        self.routeView = new RouteView();
<<<<<<< HEAD
        self.mainView = new MainView();
        return [ self.mainView, new navDelegate() ];
=======
        return [ self.routeView, new navDelegate() ];
>>>>>>> 467900165ee1dcbb4ae9a7999b010a751fcc5dc1
    }

    function messageReceived(message){
		if(message.data["type"].toString().equals("routeSteps")){
			routeSteps = new [message.data["data"].size()];
			for(var i = 0; i < routeSteps.size(); i++){
				routeSteps[i] = new RouteStep(message.data["data"][i]["passed"],
												 message.data["data"][i]["instruction"],
												 message.data["data"][i]["type"],
												 new Position.Location({
												 :latitude => message.data["data"][i]["startPoint"]["latitude"],
        										 :longitude => message.data["data"][i]["startPoint"]["longitude"],
        										 :format => :degrees}),
												 new Position.Location({
												 :latitude => message.data["data"][i]["endPoint"]["latitude"],
        										 :longitude => message.data["data"][i]["endPoint"]["longitude"],
        										 :format => :degrees}), 
        										 message.data["data"][i]["startWayPoint"],
        										 message.data["data"][i]["finishWayPoint"],
        										 message.data["data"][i]["distance"]);
			}
			System.println("routeSteps ok");
<<<<<<< HEAD
			
=======
			//startNavigate();
>>>>>>> 467900165ee1dcbb4ae9a7999b010a751fcc5dc1
		}
		if(message.data["type"].toString().equals("routePoints")){
			wayPoints = new [message.data["data"].size()];
			for(var i = 0; i < wayPoints.size(); i++){
				wayPoints[i] = new Position.Location({
												 :latitude => message.data["data"][i]["latitude"],
        										 :longitude => message.data["data"][i]["longitude"],
        										 :format => :degrees});
			}
			System.println("waypoints ok");
		}
        if(message.data["type"].toString().equals("boundingBox")){
            System.println(message.data);
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
            for(var i = 0; i < wayPoints.size(); i++){
                System.println("Pozice: " + i + " Lat: " + wayPoints[i].toDegrees()[1] + " Lon: " + wayPoints[i].toDegrees()[0]);
                latLongToPixels[i] = transformToPixels(wayPoints[i].toDegrees()[0], wayPoints[i].toDegrees()[1]); 
                System.println("Pozice: " + i + " X: " + latLongToPixels[i][0] + " Y: " + latLongToPixels[i][1]);
            }
            routeView.setCoords(latLongToPixels);
            routeView.onShow();
            System.println("bb ok");
		}
	}

    function transformToPixels(lat, lon){
        var westLongitude = boundingBox[1].toDegrees()[1]; 
        var eastLongitude = boundingBox[0].toDegrees()[1];
        var northLatitude = boundingBox[1].toDegrees()[0];
        var southLatitude = boundingBox[0].toDegrees()[0];
        var longitudeDiff = eastLongitude - westLongitude;
        var latitudeDiff = northLatitude - southLatitude;
        var xPixel = (((eastLongitude - lon) / (longitudeDiff).toDouble()) * 165).toNumber();
        var yPixel = (((northLatitude - lat) / (latitudeDiff).toDouble()) * 145).toNumber();
        var result = new [2];
        result[1] = xPixel - 3;
        result[0] = yPixel + 25;
        return result;
    }    
}
