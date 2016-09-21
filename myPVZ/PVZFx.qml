import QtQuick 2.7

Item {
    Rectangle{
        id: mask
        opacity: 0
        visible: false
        anchors.fill: parent
        color: "black"
    }

    NumberAnimation {
        id: maskFadeIn
        target: mask
        property: "opacity"
        to: 1; running: false
        duration: 1000
        easing.type: Easing.InOutQuad
        property var myStarted
        property var myStopped
        onStarted: { mask.visible = true; console.log("fadeIn start!!") ;if(myStarted) myStarted()}
        onStopped: { maskFadeOut.restart(); if(myStopped) myStopped()}
    }

    NumberAnimation {
        id: maskFadeOut
        target: mask
        property: "opacity"
        to: 0
        duration: 750; running: false
        easing.type: Easing.InOutQuad
        property var myStopped
        onStopped: {  mask.visible = false;console.log("fadeOut stop!!");if(myStopped) myStopped()}
    }
    function switchScene(start, stop){
        maskFadeIn.myStarted = function(){
            start()
        }
        maskFadeIn.myStopped = function(){
            stop()
        }
        maskFadeIn.restart()
    }

    Image{
        id: gameBgAnimation
        source: "res/images/surface/NormalGrass.png"
        x: 0; y: 0
        visible: false
    }
    NumberAnimation {
        id: gameStart
        target: gameBgAnimation
        property: "x"; to: -500
        duration: 2000; running: false
        onStarted: { gameBgAnimation.visible = true}
        onStopped: { pause2Sec.restart()}
    }
    Timer{
        id: pause2Sec
        interval: 2000
        running: false
        onTriggered: gameStop.restart()
    }

    NumberAnimation {
        id: gameStop
        target: gameBgAnimation
        property: "x"; to: -80
        duration: 2000; running: false
        easing.type: Easing.InOutQuad
        onStopped: {beforeStartAnimation.restart()}
    }
    function startGame(){
        gameStart.restart()
    }

    Image{
        id: beforeStart
        anchors.centerIn: parent
        source: "res/images/surface/StartSet.png"
        opacity: 0.9
        visible: false
    }

    NumberAnimation {
        id: beforeStartAnimation
        target: beforeStart
        property: "opacity"
        to: 1; running: false
        duration: 1000
        easing.type: Easing.InOutQuad
        onStarted: { beforeStart.visible = true}
        onStopped: { stop1Sec.restart(); beforeStart.source = "res/images/surface/StartReady.png"}
    }
    Timer{
        id: stop1Sec
        interval: 2000
        running: false
        onTriggered: {beforeStart.source = "res/images/surface/StartPlant.png"; stop07Sec.restart()}
    }
    Timer{
        id: stop07Sec
        interval: 2000
        running: false
        onTriggered: {
            beforeStart.visible = false;game.visible = true
            gameBgAnimation.visible = false
        }
    }



}





