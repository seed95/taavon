import QtQuick 2.0

Rectangle
{
    property string btnText: ""
    property string btnIcon: ""

    property color color_background_normal:     "#c5c9d3"
    property color color_background_hovered:    "#e2e4e9"

    property color color_text_normal:     "#2f343f"
    property color color_text_hovered:    "#21242c"

    property color color_border_normal:     color_text_normal
    property color color_border_hovered:    color_text_hovered

    property bool isHovered:    false

    height: 34
    radius: 5
    border.width: 1
    border.color:
    {
        if (isHovered)
        {
            color_border_hovered
        }
        else
        {
            color_border_normal
        }
    }
    color:
    {
        if (isHovered)
        {
            color_background_hovered
        }
        else
        {
            color_background_normal
        }
    }


    Text
    {
        id: btn_icon
        text: btnIcon
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 12
        font.family: fontAwesomeSolid.name
        color:
        {
            if (isHovered)
            {
                color_text_hovered
            }
            else
            {
                color_text_normal
            }
        }
    }

    Text
    {
        text: btnText
        anchors.right: btn_icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 16
        font.family: iranSansWeb.name
        color:
        {
            if (isHovered)
            {
                color_text_hovered
            }
            else
            {
                color_text_normal
            }
        }


    }

    MouseArea
    {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onEntered: isHovered = true
        onExited: isHovered = false
    }

}
