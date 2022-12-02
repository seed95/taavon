import QtQuick 2.0

Rectangle
{
    property bool isActive: false
    property string btnText: ""
    property string btnIcon: ""
    property int textWidth: 0

    property color color_background_normal:     "#c5c9d3"
    property color color_background_hovered:    "#e2e4e9"

    property color color_text_normal:     "#2f343f"
    property color color_text_hovered:    "#21242c"

    property color color_border_normal:     "#21242c"
    property color color_border_hovered:    "#16181d"

    property bool isHovered:    false

    signal clickButton()

    height: 35
    radius: 5
    border.width: 1
    border.color: isHovered? color_border_hovered : color_border_normal
    color: isHovered? color_background_hovered : color_background_normal

    Item
    {
        width: textWidth
        anchors.centerIn: parent

        Text
        {
            id: btn_icon
            text: btnIcon
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 16
            font.family: fontAwesomeSolid.name
            color: isHovered? color_text_hovered : color_text_normal
        }

        Text
        {
            text: btnText
            anchors.right: btn_icon.left
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 16
            font.family: iranSansWeb.name
            color: isHovered? color_text_hovered : color_text_normal
        }

    }

    MouseArea
    {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: isActive? Qt.PointingHandCursor : Qt.ArrowCursor
        enabled: isActive

        onEntered: isHovered = true
        onExited: isHovered = false
        onClicked:
        {
            clickButton()
        }
    }

}
