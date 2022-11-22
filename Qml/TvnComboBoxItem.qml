import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle
{

    property int index: 0
    property bool isHovered: false
    property bool isChecked: false
    property string displayText: ""


    property color color_background_normal: "#2b313b"
    property color color_background_hovered: "#576075"

    property color color_text_normal: "#e8e9e3"
    property color color_text_hovered: "#fafbf9"

    property color color_box_normal: color_text_normal
    property color color_box_hovered: color_text_hovered

    height: 35
    width: parent.width
    color: isHovered? color_background_hovered : color_background_normal

    Rectangle
    {
        id: check_box
        width: 12
        height: 12
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 5
        color: "transparent"
        border.width: 1
        border.color: isHovered? color_box_hovered : color_box_normal

        Text
        {
            id: checked
            anchors.centerIn: parent
            text: "\uf00c"
            font.family: fontAwesomeSolid.name
            font.pixelSize: 12
            color: isHovered? color_box_hovered : color_box_normal
            visible: isChecked
        }

    }

    Item
    {
        height: parent.height
        anchors.right: check_box.left
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter

        Text
        {
            text: displayText
            anchors.centerIn: parent
            font.family: iranSansWeb.name
            font.pixelSize: 17
            color: isHovered? color_text_hovered : color_text_normal
        }
    }

}
