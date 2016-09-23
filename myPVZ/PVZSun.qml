import QtQuick 2.7

AnimatedImage{
    id: sunFlowerSuns
    property bool show: false
    property bool sunFlag
    property int number

    source : {if(sunFlag) "res/images/surface/Sun.gif"; else return ""}
    property real cur_x: 15
    property real cur_y: 15
    x: 15; y:15
    // normal prop
    visible : show
    onShowChanged:{
        if(show){
            showSun.restart()
        }
    }

    NumberAnimation on x{
        id: disappearX; running: false; duration: 750
        to: -(174+(number%9)*82);
        onStopped:{sunFlowerSuns.x = sunFlowerSuns.cur_x; sun += 25; show = false}
    }
    NumberAnimation on y{
        id: disappearY; running: false; duration: 750
        to: -(80+(Math.floor(number/9))*82);
        onStopped:{sunFlowerSuns.y = sunFlowerSuns.cur_y; sun += 25}
    }
    NumberAnimation on scale{
        id: showSun; running: false; duration: 750
        from: 0; to: 1
        onStopped:{
            //show = false

            //event
        }
    }

    // random suns
    NumberAnimation on y{
        id: fall; running: false; duration: 3000
        from: -(94*Math.floor(index/9)+80); to: sunFlowerSuns.cur_y
        easing.type: Easing.InOutQuad;
        onStarted: {eventListen()}
    }

    MouseArea{
        id: sunsEvent
        anchors.fill: parent
        onClicked: {
            sunFlowerSuns.disappear()
            console.log("sun collected!!!")
        }
    }
    function disappear(){
        disappearX.restart()
        disappearY.restart()
        sunTimer.restart()
    }

    Timer{
        id: sunTimer
        interval: 5000
        running: sunFlag
        onTriggered: {
            show = true  // to line 15
        }
    }

}



