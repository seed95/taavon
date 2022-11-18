import QtQuick 2.0
import QtQuick.Controls 2.5


Item
{

    property string titleText: ""
    property int inputWidth: 0

    property color color_background_normal:     "#3b4351"
    property color color_background_hovered:    "#576075"

    property color color_text_normal:           "#e8e9e2"
    property color color_text_hovered:          "#fafbf9"

    property color color_border_normal:         color_text_normal
    property color color_border_hovered:        color_text_hovered


    property bool isHovered: false
    property bool isActive: false


    height: 45
    width: title.contentWidth + rect_input.width

    Text
    {
        id: title
        text: titleText + ":"
        color: "#c5c74d"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        font.family: iranSansWebBold.name
        font.pixelSize: 18
        font.bold: true
    }

    Rectangle
    {
        id: rect_input
        width: inputWidth
        height: 34
        anchors.right: title.left
        anchors.rightMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        radius: 4
        border.width: 1
        border.color:
        {
            if(text_input.focus)
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
            if(text_input.focus)
            {
                color_background_hovered
            }
            else
            {
                color_background_normal
            }
        }


        TextField
        {
            id: text_input

            width: inputWidth
            text: "127"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            horizontalAlignment: TextInput.AlignHCenter
            font.family: iranSansWeb.name
            font.pixelSize: 16
            selectByMouse: true
            enabled: true
            validator: IntValidator {bottom: 1; top: 1000}
//            selectedTextColor: "#888"
//            selectionColor: "#222"
            background: Rectangle{color: "transparent"}
            color:
            {
                if(focus)
                {
                    color_text_hovered
                }
                else
                {
                    color_text_normal
                }
            }


            onFocusChanged:
            {
                if( focus )
                {
                    text = ""
                }
            }
            onAccepted:
            {
                focus = false
            }
        }
    }



}