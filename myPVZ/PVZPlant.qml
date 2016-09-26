import QtQuick 2.7

AnimatedImage {
    id: plant
    property var plants: ["", "res/images/plant/Peashooter/Peashooter.gif",
        "res/images/plant/SunFlower/SunFlower1.gif", "res/images/plant/WallNut/WallNut.gif"]

    property int isPlant: 0
    property int blood: {if(isPlant == 3) return 400; else return 100}
    source: plants[isPlant]


}

