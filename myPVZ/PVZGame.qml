import QtQuick 2.7

Item {
    id:game
    width: 900; height: 600

    property int sun: 50
    property int plantWhat: 0
    property bool flag: true
    property bool plantFlag: false
    property bool readyToPlant: false

    onSunChanged: {
        var cost = [100, 50, 50]
        for(var i = 0; i < cost.length; i++){
            if(sun < cost[i]){
                ui.coldShow(i)
            }else{
                ui.coldDown(i)
            }
        }
    }

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
            var cost = [100, 50, 50]
            if(plantWhat !== 0){
                for(var i = 0; i < 45; i++){
                    if( mouseX >= 174 + (i%9)*82 && mouseX <= 174 + ((i%9)+1)*82
                            && mouseY >= 80 + Math.floor(i/9)*92 && mouseY <=
                            80 + Math.floor((i/9)+1)*92 && mainField.itemAt(i).isPlant === 0){
                        mainField.itemAt(i).isPlant = plantWhat
                        sun -= cost[plantWhat - 1]
                        if( sun >= cost[plantWhat - 1])
                            ui.coldRestart(plantWhat - 1)
                        plantWhat = 0; isPlant0.source = ""
                        readyToPlant = false
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

            onBeHurtChanged: {
                if(!beHurt){
                    hurt.myTriggered = {}
                    hurt.stop()
                }
            }

            function beHurtListener(){
                if(field.beHurt){
                    //var cur_blood = field.blood
                    if(field.blood >= 0){
                        hurt.myTriggered = function(){
                            field.blood -= 25
                            console.log("new blood: ", field.blood, field.beHurt)
                            if(beHurt){
                                if(field.blood > 0){
                                    hurt.restart()
                                }else{
                                    field.isPlant = 0
                                    hurt.myTriggered = {}
                                    field.beHurt = false
                                    field.blood = 100
                                }
                            }
                        }
                        hurt.start()
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
            blood: 200
            force: 20
            speed: 50000
            line: 4 //index%5　+ 1
            onXChanged:  {
                var cur_blood
                if(x <= 900 && !dead){
                    for(var i = 0; i < 9; i++){
                        if(mainField.itemAt(i + 9*(line - 1)).isPlant === 1){
                            if(mainField.itemAt(i + 9*(line - 1)).peaX - 30 >= zombie.x){
                                mainField.itemAt(i + 9*(line - 1)).makePeaRestart()
                                if(flag){
                                    zombie.blood -= 25
                                    console.log(" zombie, blood ")
                                    if(zombie.blood < 0){
                                        zombie.dead = true
                                    }
                                    flag = false
                                }
                            }
                        }
                        if(x >= mainField.itemAt(i + 9*(line - 1)).x - 80 && x <= mainField.itemAt(i + 9*(line - 1)).x + mainField.itemAt(i + 9*(line - 1)).width - 80){
                            if(mainField.itemAt(i + 9*(line - 1)).isPlant !== 0){
                                mainField.itemAt(i + 9*(line - 1)).beHurt = true
                                mainField.itemAt(i + 9*(line - 1)).beHurtListener()
                                attack = true; attackDetect()
                            }/*else if(dead){
                                mainField.itemAt(i + 9*(line - 1)).beHurt = false
                            }*/else{
                                attack = false; attackDetect()
                            }
                            if(dead){
                                mainField.itemAt(i + 9*(line - 1)).beHurt = false
                            }
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
