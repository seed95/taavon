import QtQuick 2.5
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4

Item
{
    property int radiusButton: 0
    property int typeButton: 0 // 1 --> right round, 2 --> left round
    property bool disabledButton: false
    property bool clickable: false
    property string textButton: ""
    property string fontName: iranSansWeb.name
    property int fontWeight: Font.Normal
    property int fontSize: 16


    property color color_background_normal: "#3b4351"
    property color color_background_hovered: "#576075"
    property color color_background_disable: "#3b4351"
    property color color_background:
    {
        if (disabledButton)
        {
            color_background_disable
        }
        else
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
    }

    property color color_text_normal: "#e8e9e3"
    property color color_text_hovered: "#fafbf9"
    property color color_text_disable: "#a9aaaa"
    property color color_text:
    {
        if (disabledButton)
        {
            color_text_disable
        }
        else
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

    property color color_border_normal: color_text_normal
    property color color_border_hovered: color_text_hovered
    property color color_border_disable: color_text_disable
    property color color_border:
    {
        if (disabledButton)
        {
            color_border_disable
        }
        else
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
    }

    property bool isHovered: false
    property int border_width: 1

    signal buttonClicked()

    Rectangle
    {
        id: rnd1
        height: parent.height
        width: typeButton===2? (parent.width/2 + radiusButton): parent.width/2
        anchors.top: parent.top
        anchors.right: parent.right
        radius: typeButton===1? radiusButton : 0
        color: color_background
        border.width: border_width
        border.color: color_border
    }

    Rectangle
    {
        id: rnd2
        height: parent.height
        width: typeButton===1? (parent.width/2 + radiusButton): parent.width/2
        anchors.top: parent.top
        anchors.left:  parent.left
        radius: typeButton===2? radiusButton : 0
        color: color_background
        border.width: border_width
        border.color: color_border
    }

    Rectangle
    {
        width: radiusButton*3
        height: parent.height - border_width*2
        anchors.top: parent.top
        anchors.topMargin: border_width
        anchors.centerIn: parent
        color: color_background
    }

    Text
    {
        anchors.centerIn: parent
        text: textButton
        font.family: fontName
        font.weight: fontWeight
        font.pixelSize: fontSize
        color: color_text
    }

    MouseArea
    {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: clickable? Qt.PointingHandCursor : Qt.ArrowCursor
        visible: clickable

        onEntered: isHovered = true
        onExited: isHovered = false
        onClicked: buttonClicked()
    }

}

