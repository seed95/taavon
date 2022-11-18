import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {


    property int index: 0
    property string displayText: ""


    property color color_background_normal: "#3b4351"
    property color color_background_hovered: "#576075"


    height: 35
//    color: color_background_normal
    color: "transparent"

    Rectangle
    {
        id: check_box
        width: 10
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 5
    }

    Rectangle
    {
        height: parent.height
        anchors.right: check_box.left
        anchors.left: parent.left
//        anchors.verticalCenter: parent.verticalCenter
        anchors.top: parent.top
        color: "transparent"

        Text
        {
            anchors.centerIn: parent
//            anchors.leftMargin: 10
            text: displayText
            font: iranSansWeb.name
//            color: control.pressed ? "#fafbf9" : "#e8e9e3"
//            horizontalAlignment: Text.AlignHCenter
//            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
    }



}
