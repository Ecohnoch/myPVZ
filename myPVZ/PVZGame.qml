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
        id: isPlant
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
                isPlant.source = "res/images/plant/"+(plantWhat-1)+".gif"
                isPlant.x = mouseX - isPlant.width/2; isPlant.y = mouseY - isPlant.height/2
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
//            PVZEvent{
//                anchors.fill: parent
//                flag: 1
//            }
            PVZSun{
                sunFlag: {if(parent.isPlant == 2) return true; else return false}
                number: index
            }
            PVZPean{
                x: field.width
                peaFlag: {if(field.isPlant == 1) return true; else return false}
                property int line :field.line
            }

        }
    }

    PVZFight{
        id: fight
    }
    PVZUi{
        id: ui
    }
}
