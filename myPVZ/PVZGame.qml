import QtQuick 2.7

Item {
    width: 900; height: 600
    Image{
        id: gameBg
        source:"res/images/surface/NormalGrass.png"
        x: 0; y:0
    }

    MouseArea{
        id: mainEvent
        property bool transing: true  // if false , then fuck off
    }
}
