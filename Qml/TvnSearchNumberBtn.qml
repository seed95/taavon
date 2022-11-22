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

    height: 45
    width: title.contentWidth + rect_input.width + rect_input.anchors.rightMargin

    Text
    {
        id: title
        text: titleText + ":"
        color: "#c5c74d"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 16
        font.family: iranSansWebBold.name
        font.weight: Font.Bold
    }

    Rectangle
    {
        id: rect_input
        width: inputWidth
        height: 35
        anchors.right: title.left
        anchors.rightMargin: 9
        anchors.verticalCenter: parent.verticalCenter
        radius: 5
        border.width: 1
        border.color: text_input.focus? color_border_hovered : color_border_normal
        color: text_input.focus? color_background_hovered : color_background_normal

        TextField
        {
            id: text_input

            width: inputWidth
            text: ""
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            horizontalAlignment: TextInput.AlignHCenter
            font.family: iranSansWeb.name
            font.pixelSize: 16
            selectByMouse: true
            validator: IntValidator {bottom: 1; top: 1000; locale: "fa"}
            background: Rectangle{color: "transparent"}
            color: focus? color_text_hovered: color_text_normal
            onFocusChanged:
            {
                if (focus)
                {
                    text = ""
                }
            }
            onAccepted: focus = false
            Keys.onEscapePressed: {focus = false;root.updateFocus()}
//            Keys.onEnterPressed:
//            {
//                dataEntered();
//            }

//            Keys.onReturnPressed:
//            {
//                dataEntered();
//            }

        }
    }

}
