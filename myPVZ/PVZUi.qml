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


    Image{
        id: choseMenu
        source: "res/images/surface/CardSlot.png"
        x: 0; y: 0;
        property var plantSource: ["Peashooter", "Sunflower", "WallNut"]
        Repeater{
            id: plantCard
            model: 3
            Image{
                id: cards
                source: "res/images/card/"+choseMenu.plantSource[index]+".png"
                x: 84 + (index)*60; y: 10
                Image{
                    id: coldDown
                    source: "res/images/card/DisableCard.png"
                    x: 0; y: 0; visible: false
                }
                NumberAnimation{
                    id: cold; target: coldDown; property: "height";
                    from: 63; to: 0; running: false; duration: 2000
                    onStarted: {choseToPlant.enabled = false; coldDown.visible = true}
                    onStopped: {choseToPlant.enabled = true; coldDown.visible = false}
                }

                function __coldRestart(){
                    cold.restart()
                }

                MouseArea{
                    id: choseToPlant
                    anchors.fill: parent
                    onClicked:{
                        readyToPlant = !readyToPlant
                        if(readyToPlant)
                            plantWhat = index + 1
                        else
                            plantWhat = 0
                    }
                }
            }
        }
        function coldRestart(i){
            plantCard.itemAt(i).__coldRestart()
        }
    }
    function coldRestart(i){
        choseMenu.coldRestart(i)
    }

    Rectangle{
        id: sunNum
        x: 11; y: 58
        width: 52; height: 22
        Text{
            anchors.centerIn: parent
            text: ""+sun
            font.pixelSize: 16
        }
    }

}
