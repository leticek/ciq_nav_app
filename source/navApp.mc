using Toybox.Application;
using Toybox.WatchUi;

class NavApp extends Application.AppBase {

    hidden var mainView;
    hidden var routeView;

    function initialize() {
        mainView = new MainView();
        routeView =  new RouteView();
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
        var mmainView = new MainView();
        var rrouteView =  new RouteView();

        return [ rrouteView, new navDelegate() ];
    }

}
