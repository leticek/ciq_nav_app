using Toybox.Application;
using Toybox.Position;
using Toybox.Communications;
using Toybox.WatchUi;

class NavApp extends Application.AppBase {

    hidden var routeSteps;
    hidden var wayPoints;
    hidden var boundingBox;
    hidden var LatLongToPixels;

    function initialize() {
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
        var rrouteView =  new RouteView();
        return [ rrouteView, new navDelegate() ];
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
			//startNavigate();
		}
		if(message.data["type"].toString().equals("routePoints")){
			wayPoints = new [message.data["data"].size()];
			for(var i = 0; i < wayPoints.size(); i++){
				wayPoints[i] = new Position.Location({
												 :latitude => message.data["data"][i]["latitude"],
        										 :longitude => message.data["data"][i]["longitude"],
        										 :format => :degrees});
			}
		}
        if(message.data["type"].toString().equals("boundingBox")){
            System.print(message.data);
			boundingBox = new [2];
            boundingBox[0] = new Position.Location({
												 :latitude => message.data["data"][1],
        										 :longitude => message.data["data"][0],
        										 :format => :degrees});
            boundingBox[1] = new Position.Location({
												 :latitude => message.data["data"][3],
        										 :longitude => message.data["data"][2],
        										 :format => :degrees});
            LatLongToPixels = new [wayPoints.size()];
            for(var i = 0; i < wayPoints.size(); i++){
                System.println("Pozice: " + i + " Lat: " + wayPoints[i][1] + " Lon: " + wayPoints[i][0]);
                LatLongToPixels[i] = calculatePixel(wayPoints[i][1], wayPoints[i][0]);
                System.println("Pozice: " + i + " X: " + LatLongToPixels[i][0] + " Y: " + LatLongToPixels[i][1]);
            }
		}
	}

    function calculatePixel(inputLatitude, inputLongitude){
        var longitudeDiff = eastLongitude - leftLongitude;
        var latitudeDiff = northLatitude - southLatitude;
        var xPixel = (((eastLongitude - inputLongitude) / (longitudeDiff).toDouble()) * 170).toNumber();
        var yPixel = (((northLatitude - inputLatitude) / (latitudeDiff).toDouble()) * 170).toNumber();
        var result = new [2];
        result[0] = xPixel;
        result[1] = yPixel; // y points south
        return result;
    }

}
