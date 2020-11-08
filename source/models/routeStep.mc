class RouteStep {
	var hasPassed;
  	var stepInstruction;
  	var instructionType;
  	var startPoint;
  	var endPoint;
  	var startWayPoint;
  	var finishWayPoint;
  	var distance;
  	
  	
  	function initialize(passed, ins, type, start, end, sWayPoint, fWayPoint, dist){
  		self.hasPassed = passed;
  		self.stepInstruction = ins;
  		self.instructionType = type;
  		self.startPoint = start;
  		self.endPoint = end;
  		self.startWayPoint = sWayPoint;
  		self.finishWayPoint = fWayPoint;
  		self.distance = dist;
  	}
  	
}