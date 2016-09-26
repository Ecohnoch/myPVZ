import QtQuick 2.7
import QtMultimedia 5.4

Video {
    property bool bgmSwith: false
    property bool seSwith: false

    id: bgm
    source: "res/audio/Faster.mp3"
    autoPlay: true
    volume: 0
    onStopped: bgm.play()
    function switchTo(path){
        bgm.source = "res/audio/" + path +".mp3"
    }

    Video{
        id: se
        source:""
        autoPlay: false
    }
    function stopBgm(bool){
        console.log("bgm stop!")
        if(bool) bgm.pause()
        else bgm.play()
    }
    function stopSe(bool){
        console.log("se stop!")
        if(bool) se.volume = 0
        else se.volume = 1
    }
}
