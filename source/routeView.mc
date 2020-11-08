using Toybox.Application;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Math;
using Toybox.Lang;

class RouteView extends WatchUi.View {

    hidden var xyCoords;
    /*hidden var leftLongitude; = 18.548841;
    hidden var eastLongitude; = 18.560379;
    hidden var northLatitude; = 49.899702;
    hidden var southLatitude; = 49.892958;*/

    function intialize(lLongitude, eLongitude, nLatitude, sLatitude){
        leftLongitude = lLongitude;
        eastLongitude = eLongitude;
        northLatitude = nLatitude;
        southLatitude = sLatitude;
        View.initialize();
    }

    function onLayout(dc){

    } 
    
    function onShow(){
    }
    
    function onUpdate(dc){
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.clear();
        //dc.fillRectangle(0, 0, 50, 50);
        for(var i = 0; i < xyCoords.size(); i++){
            //dc.drawPoint(xyCoords[i][0], xyCoords[i][1]);
            dc.fillRoundedRectangle(xyCoords[i][1] + 25, xyCoords[i][0] + 10, 1, 1, 0.5);
            if(i != xyCoords.size() - 1){dc.drawLine(xyCoords[i][1] + 25, xyCoords[i][0] + 10, xyCoords[i + 1][1] + 25, xyCoords[i + 1][0] + 10);
            }
        }
        //dc.drawText(dc.getWidth() / 2, 120, 9, "instruction" , Graphics.TEXT_JUSTIFY_CENTER);
    }

    function onHide(){

    }

var points = [[18.560379,49.899702],[18.56037,49.899692],[18.560309,49.899544],
                    [18.560286,49.899369],[18.559879,49.898865],[18.559784,49.898692],
                    [18.559665,49.898536],[18.559488,49.898442],[18.55934,49.898422],
                    [18.559063,49.898465],[18.558427,49.898642],[18.557927,49.898734],
                    [18.557848,49.898749],[18.55741,49.898814],[18.557312,49.898791],
                    [18.557185,49.898705],[18.557082,49.898505],[18.556997,49.898406],
                    [18.556863,49.898329],[18.556698,49.898297],[18.556311,49.898292],
                    [18.556184,49.898263],[18.5561,49.898191],[18.555931,49.897905],
                    [18.555663,49.897591],[18.555333,49.897415],[18.554938,49.897277],
                    [18.554634,49.897145],[18.554392,49.896967],[18.554167,49.896695],
                    [18.554015,49.896615],[18.5538,49.8966],[18.553519,49.896644],
                    [18.553304,49.896738],[18.553124,49.896851],[18.552983,49.896873],
                    [18.552695,49.896815],[18.552532,49.896742],[18.552064,49.896306],
                    [18.551805,49.895976],[18.551647,49.895533],[18.551495,49.895028],
                    [18.551312,49.894887],[18.552895,49.894378],[18.552586,49.893984],
                    [18.552042,49.89323],[18.551847,49.892958],[18.551579,49.893025],
                    [18.550607,49.8933],[18.550523,49.893207],[18.549757,49.893436],
                    [18.549288,49.893546],[18.548841,49.893682]];



}