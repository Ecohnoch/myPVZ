import QtQuick 2.7

MouseArea{
    property bool transing: false
    property int flag: 0

    onClicked: {
        if(plantFlag)
            parent.isPlant = flag
        else
            return
    }

}
