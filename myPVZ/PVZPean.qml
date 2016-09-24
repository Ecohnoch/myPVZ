import QtQuick 2.7

Image{
    id: pea
    property bool peaFlag
    x: parent.width - 5
    visible: true
    source: {if(peaFlag) return "res/images/plant/pea.png"; else return ""}
    NumberAnimation on x {
        id: shoot
        duration: 2000
        from: parent.width - 5
        to: 900;
        loops: Animation.Infinite
    }
    function shootRestart(){
        shoot.restart()
    }

}
