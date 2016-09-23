import QtQuick 2.7

Image{
    id: pea
    property bool peaFlag
    x: parent.width - 5
    visible: true
    source: {if(peaFlag) return "res/images/plant/pea.png"; else return ""}
    NumberAnimation on x {
        id: shoot
        duration: 2000
        from: parent.width - 5
        to: 900;
        loops: Animation.Infinite
//        onStarted: { pea.visible = true}
//        //******************************
//        running: true
//        //******************************
//        onStopped:{
//            //pea.visible = false
//            shoot.restart()
//            console.log("restart!", pea.source)
//        }
    }
    onXChanged: {
        for(var i = 0; i < fight.model; i++){
            if(fight.getZombie(i, pea.x, pea.line)){
                fight.itemAt(i).blood -= 25
                if(fight.itemAt(i).blood <= 0){
                    fight.itemAt(i).source = ""
                }
                pea.x = parent.width - 5
                shoot.restart()
                console.log("zom blood:", fight.itemAt(i).blood)
            }
        }
    }

}
