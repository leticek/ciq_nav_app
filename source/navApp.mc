using Toybox.Application;
using Toybox.Position;
using Toybox.Communications;
using Toybox.WatchUi;
using Toybox.System;
using Toybox.Math;

class NavApp extends Application.AppBase {

	hidden var routeView;
    hidden var mainView;
	hidden var loadView;
	hidden var mainViewBehaviorDelegate;

	hidden var userPosition;
	hidden var ratioConvert = true; 
    
	hidden var routeSteps;
    hidden var routePoints;
    hidden var boundingBox;
    hidden var latLongToPixels;
	hidden var radius = 6371;
	hidden var topLeft;
	hidden var bottomRight;
	var dataCounter = 0;
	var gpsReady = false;
	
    function initialize() {
        AppBase.initialize();
        Communications.registerForPhoneAppMessages(method(:messageReceived));
    }

    // onStart() is called on application start up
    function onStart(state) {
		self.routeView = new RouteView();
        self.mainView = new MainView();
		self.loadView = new LoadView();
		//Position.enableLocationEvents(Position.LOCATION_ONE_SHOT, method(:onPosition));
		self.mainViewBehaviorDelegate = new MainViewBehaviorDelegate(self.mainView, self.routeView);
    }
    
    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [self.loadView];
		//return [self.mainView, self.mainViewBehaviorDelegate];
    }

    function messageReceived(message){
		if(message.data["type"].toString().equals("routeSteps")){
			try{
				routeSteps = parseRouteSteps(message);
				self.mainView.setRouteSteps(routeSteps);
				self.dataCounter += 1;
				self.loadView.requestUpdate();
				System.println("routeSteps parsed");
			}
			catch(ex){
				System.println("routeSteps exc");
				System.println(ex.getErrorMessage());
			}	
		}
		if(message.data["type"].toString().equals("routePoints")){
			try{
				routePoints = parseWayPoints(message);
				self.mainView.setRoutePoints(routePoints);
				self.dataCounter += 1;
				self.loadView.requestUpdate();
				System.println("routePoints parsed");
			}
			catch(ex){
				System.println("routePoints exc");
				System.println(ex.getErrorMessage());
			}
		}
        if(message.data["type"].toString().equals("boundingBox")){
			try{
				boundingBox = new [2];
            	boundingBox[0] = new Position.Location({
													 :latitude => message.data["data"][1],
        											 :longitude => message.data["data"][0],
        											 :format => :degrees});
            	boundingBox[1] = new Position.Location({
													 :latitude => message.data["data"][3],
        											 :longitude => message.data["data"][2],
        											 :format => :degrees});
            	latLongToPixels = new [routePoints.size()];
            	topLeft = new MyReferencePoint(26, 36, boundingBox[1].toDegrees()[0],  boundingBox[1].toDegrees()[1]);
            	bottomRight = new MyReferencePoint(191, 181, boundingBox[0].toDegrees()[0],  boundingBox[0].toDegrees()[1]);
            	topLeft.setGlobalXY(latlngToGlobalXY(topLeft.latitude, topLeft.longitude, topLeft, bottomRight));
            	bottomRight.setGlobalXY(latlngToGlobalXY(bottomRight.latitude, bottomRight.longitude, topLeft, bottomRight));                       
				setConversionRatio(topLeft, bottomRight);
            	parse(routePoints, topLeft, bottomRight, latLongToPixels, latLongToPixels.size());
            	self.routeView.setCoords(latLongToPixels);
				self.dataCounter += 1;
				self.loadView.requestUpdate();
            	System.println("converted");
			}
			catch(ex){
				System.println("boundingBox exc");
				System.println(ex.getErrorMessage());
			}
		}
	}

	function setConversionRatio(topLeft, bottomRight){
		if((topLeft.globalXY[0] - bottomRight.globalXY[0]) > (topLeft.globalXY[1] - bottomRight.globalXY[1])){
				ratioConvert = true;
		}
		else{
			ratioConvert = false;
		}
	}
	
	function parse(routePoints, topLeft, bottomRight, latLongToPixels, velikost){
		for(var i = 0; i < velikost; i++){
            latLongToPixels[i] = latlngToScreenXY(routePoints[i].toDegrees()[0], routePoints[i].toDegrees()[1], topLeft, bottomRight);   
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
		if(ratioConvert){
    		return [218 - (p0.screenX + (pos.position[0] - p0.globalXY[0]) * pos.percentageX),
					218 - (p0.screenY + (p1.globalXY[1] - pos.position[1]) * pos.percentageX)];
		}
		else{
			return [218 - (p0.screenX + (pos.position[0] - p0.globalXY[0]) * pos.percentageY),
					218 - (p0.screenY + (p1.globalXY[1] - pos.position[1]) * pos.percentageY)];
		}
	}
	
	function zoomLatlngToScreenXY(lat, lng, p0, p1, zoom){
    	var pos = new MyPoint(latlngToGlobalXY(lat, lng, p0, p1));
    	pos.percentageX = ((165) / (p1.globalXY[0] - p0.globalXY[0]));
    	pos.percentageY = ((145) / (p1.globalXY[1] - p0.globalXY[1]));
		if(ratioConvert){
    		return [218 - (p0.screenX + (pos.position[0] - p0.globalXY[0]) * (pos.percentageX * zoom)),
					218 - (p0.screenY + (p1.globalXY[1] - pos.position[1]) * (pos.percentageX * zoom))];
		}
		else{
			return [218 - (p0.screenX + (pos.position[0] - p0.globalXY[0]) * (pos.percentageY * zoom)),
					218 - (p0.screenY + (p1.globalXY[1] - pos.position[1]) * (pos.percentageY * zoom))];
		}
	}
	
	function calculateZoom(zoom){
		if(latLongToPixels != null && latLongToPixels.size() > 0){
			for(var i = 0; i < latLongToPixels.size(); i++){
            	latLongToPixels[i] = zoomLatlngToScreenXY(routePoints[i].toDegrees()[0], routePoints[i].toDegrees()[1], topLeft, bottomRight, zoom);
			}
			self.routeView.setCoords(latLongToPixels);
		}
	}
	
	function setCurrentPosition(posInfo){
		userPosition = posInfo;
		var min = 1000;
		var currentIndex = -1;
		for(var i = 0; i < routePoints.size(); i++){
			var tmp = distanceBetweenTwoPoints(routePoints[i], userPosition).abs();
			if(tmp < min){
				min = tmp;
				currentIndex = i;
			}
		}
		self.routeView.setUserPosition(currentIndex);
	}

	function distanceBetweenTwoPoints(startPoint, endPoint){
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
}
