import QtQuick 2.7

Item {
    Image{
        id: menuInGame
        source:"res/images/surface/MenuButtonNormal.png"
        x: 900 - menuInGame.width; y:0
        MouseArea{
            anchors.fill: parent
            onEntered: parent.source = "res/images/surface/MenuButtonHighlight.png"
            onClicked:{
                console.log("you clicked me!!")
            }
        }
    }

    Rectangle{
        x: 11; y: 58
        width: 52; height: 22
        Text{
            anchors.centerIn: parent
            text: ""+sun
            font.pixelSize: 16
        }
    }

}
