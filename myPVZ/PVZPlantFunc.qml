import QtQuick 2.7

Item {
    Repeater{
        id: suns
        model: 10   // max sun in the screen is 10
        AnimatedImage{
            id: sun
            source: "res/images/surface/Sun.gif"
            visible: false
            NumberAnimation on scale{
                id: sunScaleFx
                from: 0; to: 1;duration: 750; running: false
            }
            NumberAnimation on x{
                id: sunDisappearX; to: 0; duration: 750; running: false
                onStopped:{ game.sun += 25}
            }
            NumberAnimation on y{
                id: sunDisappearY; to: 0; duration: 750; running: false
                onStopped:{}
            }

            MouseArea{
                id: sunEvent
                onClicked:{
                    sunDisappearX.restart()
                    sunDisappearY.restart()
                    sunFlowerGain.myTriggered = {}

                }
            }
            function _sunShow(){
                sunScaleFx.restart()
            }
        }
        function sunShow(i){
            suns.itemAt(i)._sunShow()
        }

    }

    Timer{
        id: sunFlowerGain
        interval: 5000
        running: false
        property var myTriggered
        onTriggered: {
            if(myTriggered) myTriggered()
        }
    }
    function sunsShow(x){
        sunFlowerGain.myTriggered = function(){
            for(var i = 0; i < 10; i++){
                if(suns.itemAt(i).visible === false){
                    suns.itemAt(i).anchors.centerIn = mainField.itemAt(x)
                    suns.itemAt(i).visible = true
                    suns.sunShow(i)
                }
            }
        }
        sunFlowerGain.restart()
    }

    function mainFunc(){
        for(var i = 0; i < 45; i++){
            if(mainField.itemAt(i).isPlant === 0){
                //do nothing
            }else if(mainField.itemAt(i).isPlant === 1){
                sunsShow(i)
            }
        }

    }

}
