import QtQuick 2.7

Item {
    //80 + Math.floor((index/9))*92
    //80   172  264  365  457
    anchors.fill: parent
    property var yTable: [20, 112, 204, 305, 397]
    Timer{
        id: zombieAppear
        running: true
        interval: 5000
        onTriggered:{
            var table = [0, 1, 2, 3, 4]
            var i = table[Math.floor(Math.random()*5)]
            console.log(i)
            if(zombies.itemAt(i).x === 1000){
                zombies.itemAt(i).letGo()
            }else{
                console.log(zombies.itemAt(i).x)
            }
            zombieAppear.restart()
        }
    }

    Repeater{
        id: zombies
        model: 5
        AnimatedImage{
            id: normalZombie
            source: "res/images/zombie/Zombie/Zombie.gif"
            x: 1000; y: yTable[index]
            NumberAnimation on x{
                id: gogogo
                duration: 200000
                running: false
                to: 0
            }
            function continueGO(){
                gogogo.resume()
            }
            function letGo(){
                gogogo.restart()
            }

            //func of hurt
            function hurt(i, j){
                var x = game.getField(i)
                if(x.isPlant !== 0){
                    if(x.isBeenHurt){
                        beenHurt.myTriggered = function(){
                            if(x.blood >= 0){
                                x.blood -= 20
                                beenHurt.restart()
                                console.log("blood: ", x.blood)
                                hurt(i, j)

                            }
                            else{
                                x.isBeenHurt = false
                                x.blood = 100
                                x.isPlant = 0
                                zombies.itemAt(j).source = "res/images/zombie/Zombie/Zombie.gif"
                                zombies.itemAt(j).continueGO()
                            }
                        }
                        beenHurt.restart()
                    }
                }
            }
            Timer{
                id: beenHurt
                interval: 2000
                property var myTriggered
                onTriggered: {
                    if(myTriggered) myTriggered()
                }
            }

            onXChanged: {
                var j = game.getPosition(normalZombie.x+80, normalZombie.y+normalZombie.height)
                if(game.getField(j).isPlant !== 0){
                    gogogo.pause()
                    normalZombie.source = "res/images/zombie/Zombie/ZombieAttack.gif"
                    game.getField(j).isBeenHurt = true
                    hurt(j, index)

                }


                //                for(var i = 0; i < 9; i++){
//                    //174 + (index%9)*82
//                    if(x == 174  + (i%9)*82){
//                        var j = index*9 + i
//                        console.log("j: ", j)
//                        if(game.getField(j).isPlant !== 0){
//                            gogogo.pause()
//                            normalZombie.source = "res/images/zombie/Zombie/ZombieAttack.gif"
//                            game.getField(j).isBeenHurt = true
//                            hurt(j, index)
//                        }
//                    }
//                }
            }
        }
    }

}
