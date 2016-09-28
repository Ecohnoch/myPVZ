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
                mainLoader.source = "PVZTitle.qml"
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
            property var cost: [100, 50, 50]
            Image{
                id: cards
                source: "res/images/card/"+choseMenu.plantSource[index]+".png"
                x: 84 + (index)*60; y: 10
                Image{
                    id: coldDown
                    source: "res/images/card/DisableCard.png"
                    x: 0; y: 0; visible: {if(sun >= plantCard.cost[index]) return false; else return true}
                }
                NumberAnimation{
                    id: cold; target: coldDown; property: "height";
                    from: 63; to: 0; running: false; duration: 2000
                    onStarted: {choseToPlant.enabled = false}
                    onStopped: {choseToPlant.enabled = true}
                }

                function __coldRestart(){
                    cold.restart()
                }
                function __coldShow(){
                    coldDown.visible = true
                }
                function __coldDown(){
                    coldDown.visible = false
                }

                MouseArea{
                    id: choseToPlant
                    anchors.fill: parent
                    onClicked:{
                        if(sun >= plantCard.cost[index]){
                            readyToPlant = !readyToPlant
                            if(readyToPlant)
                                plantWhat = index + 1
                            else
                                plantWhat = 0
                        }else{
                            console.log(" fuck")
                        }
                    }
                }
            }
        }
        function coldRestart(i){
            plantCard.itemAt(i).__coldRestart()
        }
        function coldShow(i){
            plantCard.itemAt(i).__coldShow()
        }
        function coldDown(i){
            plantCard.itemAt(i).__coldDown()
        }
    }
    function coldRestart(i){
        choseMenu.coldRestart(i)
    }
    function coldShow(i){
        choseMenu.coldShow(i)
    }
    function coldDown(i){
        choseMenu.coldDown(i)
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
