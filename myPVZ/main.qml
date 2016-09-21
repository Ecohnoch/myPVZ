import QtQuick 2.7

Rectangle{
    id: mainWindow
    color: "lightblue"

    PVZMusic{
        id: music
    }

    PVZGame{
        id: game
        visible: false
    }

    Loader{
        id: mainLoader
        source: "PVZTitle.qml"
    }

    PVZFx{
        anchors.fill: parent
        id: fx
    }
}
