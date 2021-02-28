using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Communications;
using Toybox.Position;
using Toybox.Lang;
using Toybox.Application;
using Toybox.Math;
using Toybox.Time.Gregorian as Calendar;


class MainView extends WatchUi.View {

	var directionImage = null;
	var instruction = "-";
	var totalDistance = 0;
	var distance = 0;
	
    function initialize() {
        View.initialize();
        System.println("main init");
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
    (:vivoactive4s)
    function onUpdate(dc) {
  		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
    	dc.clear();
    	if(directionImage != null){
    		dc.drawBitmap(87, 30, directionImage);
    	}
    	dc.drawText(109, 120, 9, instruction , Graphics.TEXT_JUSTIFY_CENTER);
    	dc.drawText(116, 160, 10, "Distance: " + distance.toNumber() +"m", Graphics.TEXT_JUSTIFY_CENTER);  
    	dc.drawText(116, 190, 9, "Total: " + totalDistance.toNumber() +"m", Graphics.TEXT_JUSTIFY_CENTER);   
    }

    (:venusq)
    function onUpdate(dc) {
  		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
    	dc.clear();
    	if(directionImage != null){
    		dc.drawBitmap(96, 45, directionImage);
    	}
    	dc.drawText(120, 130, 9, instruction , Graphics.TEXT_JUSTIFY_CENTER);
    	dc.drawText(128, 170, 10, "Distance: " + distance.toNumber() +"m", Graphics.TEXT_JUSTIFY_CENTER);  
    	dc.drawText(128, 200, 9, "Total: " + totalDistance.toNumber() +"m", Graphics.TEXT_JUSTIFY_CENTER);   
    }

    (:fr645m)
    function onUpdate(dc) {
  		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
    	dc.clear();
    	if(directionImage != null){
    		dc.drawBitmap(100, 30, directionImage);
    	}
    	dc.drawText(120, 120, 9, instruction , Graphics.TEXT_JUSTIFY_CENTER);
    	dc.drawText(125, 160, 10, "Distance: " + distance.toNumber() +"m", Graphics.TEXT_JUSTIFY_CENTER);  
    	dc.drawText(120, 190, 9, "Total: " + totalDistance.toNumber() +"m", Graphics.TEXT_JUSTIFY_CENTER);   
    }
    

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    	System.println("main hide");
    }
}
