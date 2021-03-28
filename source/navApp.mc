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
	hidden var mainBehaviorDelegate;

	hidden var userPosition;
	hidden var ratioConvert = true; 
    
	hidden var routeSteps;
    hidden var routePoints;
    hidden var boundingBox;
    hidden var latLongToPixels;
	hidden var radius = 6371;
	hidden var topLeft;
	hidden var bottomRight;
	
	hidden var isFirstPosition = true;
	hidden var currStep = 0;
	hidden var lastKnownPosition;

	hidden var pointClosestToCenter = [];

	var canStartNavigation = false;
	var dataCounter = 0;
	var gpsReady = false;
	
    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
		self.routeView = new RouteView();
        self.mainView = new MainView();
		self.loadView = new LoadView();
		Communications.registerForPhoneAppMessages(method(:messageReceived));
		Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPosition));
		self.mainBehaviorDelegate = new MainBehaviorDelegate(self.mainView, self.routeView);
    }

	function startNavigation(){
		WatchUi.switchToView(self.mainView, self.mainBehaviorDelegate, WatchUi.SLIDE_BLINK);
	}
    
    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [self.loadView, new LoadViewBehaviorDelegate()];
		//return [self.mainView, self.mainBehaviorDelegate];
    }

	function onPosition(posInfo){
		if(!gpsReady){
			gpsReady = true;
			self.loadView.requestUpdate();
		}
		if(dataCounter == 3){
			try{
				setCurrentPosition(posInfo.position);
				var currPosition = posInfo.position;
				if(isFirstPosition){
					System.println("routeStep access");
					self.mainView.distance = routeSteps[currStep].distance;
					System.println("routeStep access -- ok");
					lastKnownPosition = currPosition;
					isFirstPosition = false;
				} 
				else{
					var traveledDistance = distanceBetweenTwoPoints(lastKnownPosition, currPosition);
					self.mainView.totalDistance += traveledDistance;
					var currDistance = self.mainView.distance - traveledDistance;
					if(currDistance < 4){
						if(currStep < routeSteps.size() - 1){
							currStep += 1;
							currDistance = routeSteps[currStep].distance;
						}	
					}
					lastKnownPosition = currPosition;
					self.mainView.distance = currDistance;
				}
				switch(routeSteps[currStep].instructionType){
					case 0:
						self.mainView.directionImage = WatchUi.loadResource(Rez.Drawables.left);
						break;
					case 1:
						self.mainView.directionImage = WatchUi.loadResource(Rez.Drawables.right);
						break;
					case 2:
						self.mainView.directionImage = WatchUi.loadResource(Rez.Drawables.sharpLeft);
						break;
					case 3:
						self.mainView.directionImage = WatchUi.loadResource(Rez.Drawables.sharpRight);
						break;
					case 4:
						self.mainView.directionImage = WatchUi.loadResource(Rez.Drawables.slightLeft);
						break;
					case 5:
						self.mainView.directionImage = WatchUi.loadResource(Rez.Drawables.slightRight);
						break;
					case 6:
						self.mainView.directionImage = WatchUi.loadResource(Rez.Drawables.straight);
						break;
					case 9:
						self.mainView.directionImage = WatchUi.loadResource(Rez.Drawables.uTurn);
						break;
					case 10:
						self.mainView.directionImage = WatchUi.loadResource(Rez.Drawables.goal);
						break;
					case 11:
						self.mainView.directionImage = WatchUi.loadResource(Rez.Drawables.depart);
						break;
					default:
						self.mainView.directionImage = WatchUi.loadResource(Rez.Drawables.depart);
						break;
				}
				self.mainView.instruction = routeSteps[currStep].stepInstruction;
				Communications.transmit({"type" => 3, "data" => currPosition.toDegrees()}, null, new PhoneConnectionListener());
				self.mainView.requestUpdate();
			}
			catch(ex){
				System.println(ex.getErrorMessage());
			}
		}
	}


    function messageReceived(message){
		if(message.data["type"].toString().equals("routeSteps")){
			try{
				routeSteps = parseRouteSteps(message);
				Communications.transmit({"type" => 0, "status" => 1}, null, new PhoneConnectionListener());
				self.dataCounter += 1;
				self.loadView.requestUpdate();
				System.println("routeSteps parsed");
			}
			catch(ex){
			Communications.transmit({"type" => 0, "status" => 0}, null, new PhoneConnectionListener());
				System.println("routeSteps exc");
				System.println(ex.getErrorMessage());
			}	
		}
		if(message.data["type"].toString().equals("routePoints")){
			try{
				routePoints = parseWayPoints(message);
				Communications.transmit({"type" => 1, "status" => 1}, null, new PhoneConnectionListener());
				self.dataCounter += 1;
				self.loadView.requestUpdate();
				System.println("routePoints parsed");
			}
			catch(ex){
			Communications.transmit({"type" => 1, "status" => 0}, null, new PhoneConnectionListener());
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
            	topLeft = new MyReferencePoint(0, 0, boundingBox[1].toDegrees()[0],  boundingBox[1].toDegrees()[1]);
            	bottomRight = new MyReferencePoint(System.getDeviceSettings().screenWidth, System.getDeviceSettings().screenHeight, boundingBox[0].toDegrees()[0],  boundingBox[0].toDegrees()[1]);
            	topLeft.setGlobalXY(latlngToGlobalXY(topLeft.latitude, topLeft.longitude, topLeft, bottomRight));
            	bottomRight.setGlobalXY(latlngToGlobalXY(bottomRight.latitude, bottomRight.longitude, topLeft, bottomRight));                       
				setConversionRatio(topLeft, bottomRight);
            	convertLatLngToPixels(routePoints, topLeft, bottomRight, latLongToPixels);
				Communications.transmit({"type" => 2, "status" => 1}, null, new PhoneConnectionListener());
            	self.routeView.setCoords(latLongToPixels);
				self.dataCounter += 1;
				self.loadView.requestUpdate();
            	System.println("converted");
			}
			catch(ex){
				Communications.transmit({"type" => 2, "status" => 0}, null, new PhoneConnectionListener());
				System.println("boundingBox exc");
				System.println(ex.getErrorMessage());
			}
		}
	}

	function setConversionRatio(topLeft, bottomRight){
		if((topLeft.globalXY[0] - bottomRight.globalXY[0]) >= (topLeft.globalXY[1] - bottomRight.globalXY[1])){
				ratioConvert = true;
		}
		else{
			ratioConvert = false;
		}
	}
	
	function convertLatLngToPixels(routePoints, topLeft, bottomRight, latLongToPixels){
		for(var i = 0; i < latLongToPixels.size(); i++){
            latLongToPixels[i] = latlngToScreenXY(routePoints[i].toDegrees()[0], routePoints[i].toDegrees()[1], topLeft, bottomRight);   
		}
	}

	function parseRouteSteps(receivedMessage){
		var parsedRouteSteps = new [receivedMessage.data["data"].size()];
		for(var i = 0; i < parsedRouteSteps.size(); i++){ 
			parsedRouteSteps[i] = new RouteStep(
											receivedMessage.data["data"][i]["instruction"],
											receivedMessage.data["data"][i]["type"],
        									receivedMessage.data["data"][i]["distance"]
											);
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
	
	function latlngToGlobalXY(lat, lng, topLeft, bottomRight){
    	var x = radius * lng * Math.cos((topLeft.latitude + bottomRight.latitude) / 2);
    	var y = radius * lat;
    	return [x, y];
	}
	
	function latlngToScreenXY(lat, lng, topLeft, bottomRight){
    	var pos = new MyPoint(latlngToGlobalXY(lat, lng, topLeft, bottomRight));
    	pos.percentageX = ((System.getDeviceSettings().screenWidth) / (bottomRight.globalXY[0] - topLeft.globalXY[0]));
    	pos.percentageY = ((System.getDeviceSettings().screenHeight) / (bottomRight.globalXY[1] - topLeft.globalXY[1]));
		if(ratioConvert){
    		return [System.getDeviceSettings().screenWidth - (topLeft.screenX + (pos.globalXYposition[0] - topLeft.globalXY[0]) * pos.percentageX),
					System.getDeviceSettings().screenHeight - (topLeft.screenY + (bottomRight.globalXY[1] - pos.globalXYposition[1]) * pos.percentageX)];
		}
		else{
			return [System.getDeviceSettings().screenWidth - (topLeft.screenX + (pos.globalXYposition[0] - topLeft.globalXY[0]) * pos.percentageY),
					System.getDeviceSettings().screenHeight - (topLeft.screenY + (bottomRight.globalXY[1] - pos.globalXYposition[1]) * pos.percentageY)];
		}
	}
	
	function zoomLatlngToScreenXY(lat, lng, topLeft, bottomRight, zoom){
    	var pos = new MyPoint(latlngToGlobalXY(lat, lng, topLeft, bottomRight));
    	pos.percentageX = ((System.getDeviceSettings().screenWidth) / (bottomRight.globalXY[0] - topLeft.globalXY[0]));
    	pos.percentageY = ((System.getDeviceSettings().screenHeight) / (bottomRight.globalXY[1] - topLeft.globalXY[1]));
		if(ratioConvert){
    		return [System.getDeviceSettings().screenWidth - (topLeft.screenX + (pos.globalXYposition[0] - topLeft.globalXY[0]) * (pos.percentageX * zoom)),
					System.getDeviceSettings().screenHeight - (topLeft.screenY + (bottomRight.globalXY[1] - pos.globalXYposition[1]) * (pos.percentageX * zoom))];
		}
		else{
			return [System.getDeviceSettings().screenWidth - (topLeft.screenX + (pos.globalXYposition[0] - topLeft.globalXY[0]) * (pos.percentageY * zoom)),
					System.getDeviceSettings().screenHeight - (topLeft.screenY + (bottomRight.globalXY[1] - pos.globalXYposition[1]) * (pos.percentageY * zoom))];
		}
	}


	function ScreenXYtoGlobalXY(screenX, screenY, topLeft, bottomRight){
    	var pos = new MyPoint([0,0]);
    	pos.percentageX = ((System.getDeviceSettings().screenWidth) / (bottomRight.globalXY[0] - topLeft.globalXY[0]));
    	pos.percentageY = ((System.getDeviceSettings().screenHeight) / (bottomRight.globalXY[1] - topLeft.globalXY[1]));
		if(ratioConvert){
			return[((System.getDeviceSettings().screenWidth - screenX - topLeft.screenX) / pos.percentageX) + topLeft.globalXY[0],
				   ((System.getDeviceSettings().screenHeight - screenY - topLeft.screenY) / pos.percentageX) + topLeft.globalXY[1]];
		}
		else{
			return[((System.getDeviceSettings().screenWidth - screenX - topLeft.screenX) / pos.percentageY) + topLeft.globalXY[0],
				   ((System.getDeviceSettings().screenHeight - screenY - topLeft.screenY) / pos.percentageY) + topLeft.globalXY[1]];
		}
	}

	function GlobalXYtoLatLng(screenX, screenY, topLeft, bottomRight){
		var lng = x / (radius * Math.cos((topLeft.latitude + bottomRight.latitude) / 2));
		var lat = y / radius;
    	return [lat, lng];
	}

	
	function calculateZoom(zoom){
		System.println("Zoom: " + zoom);
		if(latLongToPixels != null && latLongToPixels.size() > 0){
			for(var i = 0; i < latLongToPixels.size(); i++){
            	latLongToPixels[i] = zoomLatlngToScreenXY(routePoints[i].toDegrees()[0], routePoints[i].toDegrees()[1], topLeft, bottomRight, zoom);    	
			}
			self.routeView.setCoords(latLongToPixels);
		}
	}
	
	function fixZoom(point, zoom){
	
		var dx = 109 - (109 * zoom);
		var dy = 109 - (109 * zoom);
		
		return [point[0] * zoom + dx, point[1] * zoom  + dy];
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
