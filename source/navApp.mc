using Toybox.Application;
using Toybox.Position;
using Toybox.Communications;
using Toybox.WatchUi;

class NavApp extends Application.AppBase {

    hidden var routeSteps;
    hidden var wayPoints;
    hidden var boundingBox;
    hidden var latLongToPixels;
    hidden var routeView;

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
        return [ routeView, new navDelegate() ];
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
			System.println("waypoints ok");
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
            latLongToPixels = new [wayPoints.size()];
            System.println(boundingBox[0].toDegrees());
            for(var i = 0; i < wayPoints.size(); i++){
                System.println("Pozice: " + i + " Lat: " + wayPoints[i][1] + " Lon: " + wayPoints[i][0]);
                latLongToPixels[i] = calculatePixel(wayPoints[i][1], wayPoints[i][0]);
                System.println("Pozice: " + i + " X: " + latLongToPixels[i][0] + " Y: " + latLongToPixels[i][1]);
            }
            routeView = new RouteView(latLongToPixels);
            routeView.onShow();
            System.println("bb ok");
		}
	}

    function calculatePixel(inputLatitude, inputLongitude){
        var leftLongitude = boundingBox[0].toDegrees()[1];
        var eastLongitude = boundingBox[1].toDegrees()[1];
        var northLatitude = boundingBox[0].toDegrees()[0];
        var southLatitude = boundingBox[1].toDegrees()[0];
        var longitudeDiff = eastLongitude - leftLongitude;
        var latitudeDiff = northLatitude - southLatitude;
        var xPixel = (((eastLongitude - inputLongitude) / (longitudeDiff).toDouble()) * 170).toNumber();
        var yPixel = (((northLatitude - inputLatitude) / (latitudeDiff).toDouble()) * 170).toNumber();
        var result = new [2];
        result[0] = xPixel;
        result[1] = yPixel; // y points south
        return result;
    }

      class MyConnectionListener extends Communications.ConnectionListener{
  	function initialize(){
  		ConnectionListener.initialize();
  	}
	function onComplete(){}
	function onError(){}
}

}
