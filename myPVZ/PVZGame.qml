import QtQuick 2.7

Item {
    id:game
    width: 900; height: 600
    property string flag: "nothing"
    property var plants: ["Peashooter", "SunFlower", "WallNut","","",""]
    property bool ok: false // if you want to plant?
    property int randomSun: 50*Math.random()   // if > 48, the sun falls
    property int coldFlag: -1
    property var everyOk: [true, true, true, true, true, true]

    property var plantsF:[25, 0, 0]
    property var plantsB:[100, 100, 400]

    //real properties
    property int sun: 50

    Image{
        id: gameBg
        source:"res/images/surface/NormalGrass.png"
        x: -80; y:0
    }
    MouseArea{
        id: mainEvent
        anchors.fill: parent
        property bool transing: true  // if false , then fuck off
        hoverEnabled: true
        onMouseXChanged: {
            if(ok){
                for(var i = 0; i < 6; i++){
                    if(flag === plants[i]){
                        plantsFollowing.source = "res/images/plant/"+i+".gif"
                        plantsFollowing.visible = true
                        plantsFollowing.x = mouseX - plantsFollowing.width/2
                        plantsFollowing.y = mouseY - plantsFollowing.height/2
                    }
                }
            }else{

            }
        }
        onClicked:{
            console.log("position: ", mouseX, mouseY)
            plantPlants(mouseX, mouseY)
            console.log("POSITION ",getPosition(mouseX, mouseY))

        }
    }
    // x: 174 + (index%9)*82; y: 80 + Math.floor((index/9))*92
    function getPosition(x, y){
        for(var i = 0 ; i < 45; i++){
            if( x >= 174 + (i%9)*82 && x <= 174 + ((i%9)+1)*82 &&
                    y >= 80 + Math.floor((i/9))*92 && y <=  80 + Math.floor((i/9)+1)*92){
                return i
            }
        }
    }





    Repeater{
        id: mainField
        model: 45
        Rectangle{
            id: field
            property int isPlant: 0
            property bool isBeenHurt: false
            property int blood: 100
            property int force: 25
            width: 80; height: 94
            color: "#00000000"
            x: 174 + (index%9)*82; y: 80 + Math.floor((index/9))*92
            AnimatedImage{
                anchors.centerIn: field
                id: plant
                opacity: 1
                source:{
                    if(field.isPlant == 0) return ""
                    else if(field.isPlant == 1) return "res/images/plant/Peashooter/Peashooter.gif"
                    else if(field.isPlant == 2) return "res/images/plant/SunFlower/SunFlower1.gif"
                    else if(field.isPlant == 3) return "res/images/plant/WallNut/WallNut.gif"
                    else return ""
                }
            }
            AnimatedImage{
                id: sunFlowerSuns
                source : "res/images/surface/Sun.gif"
                property real cur_x: 15
                property real cur_y: 15
                visible: false;
                x: 15; y:15
                NumberAnimation on x{
                    id: disappearX; running: false; duration: 750
                    to: -((index%9)*80+174);
                    onStopped:{sunFlowerSuns.x = sunFlowerSuns.cur_x;sunFlowerSuns.visible = false; sun += 25}
                }
                NumberAnimation on y{
                    id: disappearY; running: false; duration: 750
                    to: -(94*Math.floor(index/9)+80)
                    onStopped:{sunFlowerSuns.y = sunFlowerSuns.cur_y;sunFlowerSuns.visible = false; sun += 25}
                }
                NumberAnimation on scale{
                    id: showSun; running: false; duration: 750
                    from: 0; to: 1; onStarted: {
                        if(field.isPlant === 2)
                            sunFlowerSuns.visible = true
                        else return
                    }
                    onStopped:{
                        if(field.isPlant === 2){
                            eventListen()
                        }
                        else return
                    }
                }
                NumberAnimation on y{
                    id: fall; running: false; duration: 3000
                    from: -(94*Math.floor(index/9)+80); to: sunFlowerSuns.cur_y
                    easing.type: Easing.InOutQuad;
                    onStarted: {eventListen()}
                }
                function _sunFall(){
                    fall.restart()
                }

                function disappear(){
                    disappearX.restart()
                    disappearY.restart()
                    sunsEvent.visible = false
                    whileSunShow.restart()

                }
                MouseArea{
                    id: sunsEvent
                    anchors.fill: parent
                    onClicked: {
                        sunFlowerSuns.disappear()
                        console.log("sun collected!!!")
                    }
                }
                function _eventListen(){
                    sunsEvent.visible = true
                }
                function _showSun(){
                    showSun.restart()
                }
            }
            function eventListen(){
                sunFlowerSuns._eventListen()
            }
            function showsSun(){
                sunFlowerSuns._showSun()
            }
            function sunFall(){
                sunFlowerSuns.visible = true
                sunFlowerSuns._sunFall()
            }

            Timer{
                id: whileSunShow
                running: true
                interval: 5000
                onTriggered: {
                    field.showsSun()
                }
            }
            function collectSun(){
                whileSunShow.restart()
            }


        }
    }
    Timer{
        id: sunFall
        running: true
        interval: 10000
        onTriggered:{
            var x = Math.floor(45*Math.random(0, 1))
            if(mainField.itemAt(x).isPlant === 0) mainField.itemAt(x).sunFall()
            sunFall.restart()
        }
    }

    function plantPlants(x, y){
        for( var i = 0; i < 45; i++){
            if( x >= 174 + (i%9)*82 && x <= 174 + ((i%9)+1)*82 &&
                    y >= 80 + Math.floor((i/9))*92 && y <= 80 + (Math.floor(i/9)+1)*92){
                if(flag == "Peashooter" && sun >= 100){
                    mainField.itemAt(i).isPlant = 1
                    sun -= 100
                    flag = "nothing"
                    ok = false; plantsFollowing.visible = false
                    everyOk[mainField.itemAt(i).isPlant-1] = false
                    if(coldFlag != -1) plantsFlag.coldDown(coldFlag)
                    coldFlag = -1

                }else if(flag == "SunFlower" && sun >= 50){
                    mainField.itemAt(i).isPlant = 2
                    sun -= 50
                    mainField.itemAt(i).collectSun()
                    flag = "nothing"
                    ok = false; plantsFollowing.visible = false
                    everyOk[mainField.itemAt(i).isPlant-1] = false
                    if(coldFlag != -1) plantsFlag.coldDown(coldFlag)
                    coldFlag = -1

                }else if(flag == "WallNut" && sun >= 50){
                    mainField.itemAt(i).isPlant = 3
                    sun -= 50
                    flag = "nothing"
                    ok = false; plantsFollowing.visible = false
                    everyOk[mainField.itemAt(i).isPlant-1] = false
                    if(coldFlag != -1) plantsFlag.coldDown(coldFlag)
                    coldFlag = -1

                }else{
                    flag = "nothing"
                    ok = false; plantsFollowing.visible = false
                    everyOk[mainField.itemAt(i).isPlant-1] = false
                    if(coldFlag != -1) plantsFlag.coldDown(coldFlag)
                    coldFlag = -1
                }
                console.log("which one: ", i)
            }
        }
    }



    // bot conponent
    Image{
        id: plantMenu
        source: "res/images/surface/CardSlot.png"
        x: 0; y: 0

    }

    function _canPlant(index){
        if(game.sun >= 50){
            if(game.sun >= 100)
                if(index === 0) return true
            if(index === 1 || index === 2) return true
            else return false
        }else{
            return false
        }
    }

    Repeater{
        id: plantsFlag
        model: 6
        property var staticPlant: ["Peashooter", "Sunflower", "WallNut", "WallNut", "WallNut", "WallNut"]
        Image{
            id: plantsCard
            property bool canPlant:_canPlant(index)
            width: 45; height: 63
            x: 85 + 58*(index); y: 10
            source: "res/images/card/"+plantsFlag.staticPlant[index]+".png"
            Image{
                id: bg
                x:0; y:0
                height: {
                    if(_canPlant(index)) return 0
                    else return 63
                }

                source: "res/images/card/DisableCard.png"
                NumberAnimation on height{
                    id: cold;
                    duration: 1500;
                    from: 63; to: {if(_canPlant(index)) return 0; else return 63} running: false
                    onStarted: { cardEvent.transing = false}
                    onStopped: { cardEvent.transing = true }
                }
                function __coldDown() {cold.restart()}
            }
            function _coldDown(){
                bg.__coldDown()

            }
            MouseArea{
                id: cardEvent
                property bool transing: _canPlant(index)
                anchors.fill: parent
                onClicked:{
                    if(transing){
                        if(!ok){
                            flag = plants[index]
                            coldFlag = index
                            ok = true
                        }else{
                            ok = false; flag = "nothing"
                            plantsFollowing.visible = false
                        }
                    }
                }
            }
        }
        function coldDown(i) {plantsFlag.itemAt(i)._coldDown()}
    }
    Image{
        id: plantsFollowing
        visible: ok
        source: ""
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
    function getField(x){
        return mainField.itemAt(x)
    }

    PVZFight{
        id: fight
    }
    PVZUi{
        id: ui
    }
}
