import QtQuick 2.7

//PVZZombie{
//    id: zombie1
//    blood: 100
//    force: 20
//    speed: 30000
//    line: 3
//}

AnimatedImage {
    property int blood: 100
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

    NumberAnimation on x {
        id: move
        to: 0; running: !dead
        duration: speed
    }


    function positionDetect(i)
    {
        if(i === 0) return false
        else if(i !== 0) return true
    }


    function attackDetect(){
        if(attack){
            move.pause()
            source = "res/images/zombie/Zombie/ZombieAttack.gif"
        }else{
            move.resume()
            source = "res/images/zombie/Zombie/Zombie.gif"
        }
    }

    function beAttackedDetect(){
        if(beAttacked){
            // to do , with a timer
        }
    }



}
