import QtQuick 2.7

Item {
    width: 900; height: 600
    property string flag: "nothing"
    property var plants: ["Peashooter", "SunFlower", "WallNut","","",""]

    Image{
        id: gameBg
        source:"res/images/surface/NormalGrass.png"
        x: 0; y:0
    }


    Repeater{
        id: mainField
        model: 40
        Rectangle{
            id: field
            property int isPlant: 0
            width: 80; height: 94
            color: "#00000000"
            x: 254 + (index%8)*82; y: 80 + Math.floor((index/8))*92
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
        }
    }

    MouseArea{
        id: mainEvent
        anchors.fill: parent
        property bool transing: true  // if false , then fuck off
        onClicked:{
            console.log("position: ", mouseX, mouseY)
            plantPlants(mouseX, mouseY)
        }
    }

    function plantPlants(x, y){
        for( var i = 0; i < 40; i++){
            if( x >= 254 + (i%8)*82 && x <= 254 + ((i%8)+1)*82 &&
                    y >= 80 + Math.floor((i/8))*92 && y <= 80 + (Math.floor(i/8)+1)*92){
                if(flag == "Peashooter"){
                    mainField.itemAt(i).isPlant = 1
                }else if(flag == "SunFlower"){
                    mainField.itemAt(i).isPlant = 2
                }else if(flag == "WallNut"){
                    mainField.itemAt(i).isPlant = 3
                }else{
                    mainField.itemAt(i).isPlant = 0
                }
                console.log("which one: ", i)
            }
        }
    }

//    function changePlant(x, y){
//        for(var i = 0; i < 6; i++){
//            if(x >= 75 + 45*i && x <= 75 + 55*(i+1) && y >= 4 && y <= 67){
//                flag = plants[i]
//                console.log("change the flag: ", i)
//            }

//        }
//    }


    // bot conponent
    Image{
        id: plantMenu
        source: "res/images/surface/CardSlot.png"
        x: 0; y: 0

    }
    Repeater{
        id: plantsFlag
        model: 6
        property var staticPlant: ["Peashooter", "Sunflower", "WallNut", "WallNut", "WallNut", "WallNut"]
        Image{
            width: 45; height: 63
            x: 85 + 58*(index); y: 10
            source: "res/images/card/"+plantsFlag.staticPlant[index]+".png"
            MouseArea{
                anchors.fill: parent
                onClicked:{
                    flag = plants[index]
                }
            }
        }
    }
}
