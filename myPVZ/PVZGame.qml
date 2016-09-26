import QtQuick 2.7

Item {
    id:game
    width: 900; height: 600
//    property string flag: "nothing"
//    property bool ok: false // if you want to plant?
//    property int randomSun: 50*Math.random()   // if > 48, the sun falls
//    property int coldFlag: -1
//    property var everyOk: [true, true, true, true, true, true]

//    property var plantsF:[25, 0, 0]
//    property var plantsB:[100, 100, 400]
//    property int tmpB: 100
//    //real properties
    property int sun: 50
    property int plantWhat: 1
    property bool plantFlag: false

    Image{
        id: gameBg
        source:"res/images/surface/NormalGrass.png"
        x: -80; y:0
    }
    Image{
        id: isPlant0
        source: ""
    }

    MouseArea{
        id: mainEvent
        anchors.fill: parent
        property bool transing: true
        hoverEnabled: true
        onClicked:{
            console.log("mouseX, mouseY: ", mouseX, mouseY)
            if(plantWhat !== 0){
                for(var i = 0; i < 45; i++){
                    if( mouseX >= 174 + (i%9)*82 && mouseX <= 174 + ((i%9)+1)*82
                            && mouseY >= 80 + Math.floor(i/9)*92 && mouseY <=
                            80 + Math.floor((i/9)+1)*92 && mainField.itemAt(i).isPlant === 0){
                        mainField.itemAt(i).isPlant = plantWhat
                    }
                }
            }
        }
        onMouseXChanged: {
            if(plantWhat !== 0){
                isPlant0.source = "res/images/plant/"+(plantWhat-1)+".gif"
                isPlant0.x = mouseX - isPlant0.width/2; isPlant0.y = mouseY - isPlant0.height/2
            }else{
                return
            }
        }

    }



    Repeater{
        id: mainField
        model: 45
        PVZPlant{
            id: field
            isPlant: {if(index <= 20) return 2; else return 0}
            width: 80; height: 90
            x: 174 + (index%9)*82; y: 80 + Math.floor(index/9)*92
            property int line: Math.floor(index/9)
            property real peaX: peas.x + field.x
            property bool beHurt: false
            PVZSun{
                sunFlag: {if(parent.isPlant == 2) return true; else return false}
                number: index
            }

            function makePeaRestart(){
                peas.shootRestart()
            }
            Timer{
                id: hurt; interval: 1500
                property var myTriggered
                onTriggered: {if(myTriggered) myTriggered()}
            }

            function beHurtListener(){
                if(field.beHurt){
                    if(field.blood >= 0){
                        hurt.myTriggered = function(){
                            field.blood -= 25
                            console.log("new blood: ", field.blood)
                            if(field.blood > 0){
                                hurt.restart()
                            }else{
                                field.isPlant = 0
                                hurt.myTriggered = {}
                                field.beHurt = false
                            }
                        }
                        hurt.restart()
                    }
                }
            }


            PVZPean{
                id: peas
                x: field.width
                peaFlag: {if(field.isPlant == 1) return true; else return false}
                property int line :field.line
            }
        }
        function getField(x){
            return mainField.itemAt(x)
        }
    }

    Repeater{
        id: fight
        model: 1
        PVZZombie{
            id: zombie

            x: 950
            blood: 100
            force: 20
            speed: 50000
            line: 4 //index%5　+ 1
            onXChanged:  {
                var cur_blood
                if(x <= 900){
                    for(var i = 0; i < 9; i++){
                        if(mainField.itemAt(i + 9*(line - 1)).isPlant === 1){
                            if(mainField.itemAt(i + 9*(line - 1)).peaX - 30 >= zombie.x){
                                mainField.itemAt(i + 9*(line - 1)).makePeaRestart()
                            }
                        }
                    }
                    for(var ii = 0; ii < 9; ii++){
                        var z_field = mainField.getField(ii + 9*(line - 1))
                        if(x >= z_field.x - 40 && x <= z_field.x + z_field.width - 40 && z_field.i.isPlant !== 0){
                            z_field.beHurt = true
                            z_field.beHurtListener()
                            attack = true
                            attackDetect()
                        }
                    }
                }
            }
            Timer{
                id: attackPlants
                interval: 1500
                property var myTriggered
                onTriggered: {if(myTriggered) myTriggered()}
            }
        }
        function getZombie(i, x, line, x2){
            var p = x2 + 90  //fight.itemAt(i).x + 90
            if( x >= p   && line === fight.itemAt(i).line){
                console.log(" crash!!!!!!")
                return true
            }else{
                return false
            }
        }
    }

    PVZUi{
        id: ui
    }
}
