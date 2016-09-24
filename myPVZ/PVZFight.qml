import QtQuick 2.7
Repeater{
    property var zombiesX: [900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800,
                  1900, 2000, 2100, 1400, 1500, 1600, 1700, 1500, 1800, 1900,]
    model: 20
    PVZZombie{
        id: zombie

        x: zombiesX[index]
        blood: 100
        force: 20
        speed: 50000
        line: index%5　+ 1
        onXChanged: {
            var z_x = x; var z_line = line
            var cur_blood
            for(var i = 0; i < 9; i++){
                //console.log("isPlant: ", mainField.itemAt((i+(z_line-1)*9)-1).isPlant)
//                if(mainField.itemAt((i+(z_line-1)*9)-1).isPlant === 1){
//                    if(mainField.itemAt((i+(z_line-1)*9)-1).peaX === z_x){
//                        mainField.itemAt((i+(z_line-1)*9)-1).makeShootRestart()
//                    }
//                }

                if(x >= (84 + i*82) && x <= (84 + (i+1)*82)){
                    console.log( mainField.itemAt(i+(9*line)).hasOwnProperty() )
                    if(mainField.itemAt(i+(9*line)).isPlant !== 0){
                        cur_blood = mainField.itemAt((i+(z_line-1)*9)).blood
                        zombie.attack = true
                        zombie.attackDetect()
                        attackPlants.myTriggered = function(){
                            mainField.itemAt((i+(z_line-1)*9)).blood -= 25
                            if( mainField.itemAt((i+(z_line-1)*9)).blood <= 0){
                                mainField.itemAt((i+(z_line-1)*9)).isPlant = 0
                                zombie.attack = false
                                zombie.attackDetect()
                                mainField.itemAt((i+(z_line-1)*9)).blood = cur_blood
                            }else{
                                attackPlants.restart()
                            }
                        }
                        attackPlants.restart()
                    }else{
                        zombie.attack = false
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








//import QtQuick 2.7

//Item {
//    //80 + Math.floor((index/9))*92
//    //80   172  264  365  457
//    anchors.fill: parent
//    property var yTable: [20, 112, 204, 305, 397]
//    Timer{
//        id: zombieAppear
//        running: true
//        interval: 5000
//        onTriggered:{
//            var table = [0, 1, 2, 3, 4]
//            var i = table[Math.floor(Math.random()*5)]
//            console.log(i)
//            if(zombies.itemAt(i).x === 1000){
//                zombies.itemAt(i).letGo()
//            }else{
//                console.log(zombies.itemAt(i).x)
//            }
//            zombieAppear.restart()
//        }
//    }

//    Repeater{
//        id: zombies
//        model: 5
//        AnimatedImage{
//            id: normalZombie
//            source: "res/images/zombie/Zombie/Zombie.gif"
//            x: 1000; y: yTable[index]
//            NumberAnimation on x{
//                id: gogogo
//                duration: 200000
//                running: false
//                to: 0
//            }
//            function continueGO(){
//                gogogo.resume()
//            }
//            function letGo(){
//                gogogo.restart()
//            }

//            //func of hurt
//            function hurt(i, j){
//                var x = game.getField(i)
//                if(x.isPlant !== 0){
//                    if(x.isBeenHurt){
//                        beenHurt.myTriggered = function(){
//                            if(x.blood >= 0){
//                                x.blood -= 20
//                                beenHurt.restart()
//                                console.log("blood: ", x.blood)
//                                hurt(i, j)

//                            }
//                            else{
//                                x.isBeenHurt = false
//                                x.blood = 100
//                                x.isPlant = 0
//                                zombies.itemAt(j).source = "res/images/zombie/Zombie/Zombie.gif"
//                                zombies.itemAt(j).continueGO()
//                            }
//                        }
//                        beenHurt.restart()
//                    }
//                }
//            }
//            Timer{
//                id: beenHurt
//                interval: 2000
//                property var myTriggered
//                onTriggered: {
//                    if(myTriggered) myTriggered()
//                }
//            }

//            onXChanged: {
//                var j = game.getPosition(normalZombie.x+80, normalZombie.y+normalZombie.height)
//                if(game.getField(j).isPlant !== 0){
//                    gogogo.pause()
//                    normalZombie.source = "res/images/zombie/Zombie/ZombieAttack.gif"
//                    game.getField(j).isBeenHurt = true
//                    hurt(j, index)

//                }


//                //                for(var i = 0; i < 9; i++){
////                    //174 + (index%9)*82
////                    if(x == 174  + (i%9)*82){
////                        var j = index*9 + i
////                        console.log("j: ", j)
////                        if(game.getField(j).isPlant !== 0){
////                            gogogo.pause()
////                            normalZombie.source = "res/images/zombie/Zombie/ZombieAttack.gif"
////                            game.getField(j).isBeenHurt = true
////                            hurt(j, index)
////                        }
////                    }
////                }
//            }
//        }
//    }

//}
