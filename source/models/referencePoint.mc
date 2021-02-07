class MyReferencePoint {
	var screenX;
	var screenY;
	var latitude;
	var longitude;
	var globalXY = new[2];
  	
  	
  	function initialize(scrX, scrY, lat, lon){
  		self.screenX = scrX;
  		self.screenY = scrY;
  		self.latitude = lat;
  		self.longitude = lon;
  	}
  	
  	function setGlobalXY(position){
  		self.globalXY[0] = position[0];
  		self.globalXY[1] = position[1];
  	}
  	
}