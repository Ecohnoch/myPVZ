import QtQuick 2.7

//PVZZombie{
//    id: zombie1
//    blood: 100
//    force: 20
//    speed: 30000
//    line: 3
//}

AnimatedImage {
    property int blood: 500
    property int force
    property int speed
    property bool attack: false
    property bool beAttacked: false
    property bool dead: false
    property int line: 1
    property var yLine: [60, 152, 264, 356, 448]
    property int z_x: Math.floor(x/10)
    y: yLine[line-1] - 40

    //width: 174 + (index%9)*82
    // 62 * 128

    source: {if(dead)  return ""; else return "res/images/zombie/Zombie/Zombie.gif"}

    onDeadChanged: {
        if(dead){
            deadBody.source = "res/images/zombie/Zombie/ZombieDie.gif"
            deadHead.source = "res/images/zombie/Zombie/ZombieHead.gif"
            playDead.restart()
            //x = 1100
            console.log(" zombie dead!!")
        }
    }
    AnimatedImage{
        id: deadBody
        source: ""
    }
    AnimatedImage{
        id: deadHead
        source: ""
    }
    Timer{
        id: playDead
        interval: 1000
        onTriggered: {
            deadBody.source = ""
            deadHead.source = ""
        }
    }

    NumberAnimation on x {
        id: move
        to: 0; running: !dead
        duration: speed
    }
    NumberAnimation on x{
        id: down
        to: 0; running: false
        duration: 1000000000
    }

    function positionDetect(i)
    {
        if(i === 0) return false
        else if(i !== 0) return true
    }


    function attackDetect(){
         if(attack){
             if(dead){ source = ""}
             else{
                move.pause()
                down.restart()
                source = "res/images/zombie/Zombie/ZombieAttack.gif"
             }
         }else{
             if(dead){ source = ""}
             else{
                down.stop()
                move.resume()
                source = "res/images/zombie/Zombie/Zombie.gif"
             }
        }
    }




}
