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
    	System.println("main hide");
    }
}
