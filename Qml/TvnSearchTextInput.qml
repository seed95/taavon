import QtQuick 2.0
import QtQuick.Controls 2.5

Rectangle
{
    property bool inputIsActive: false
    property var inputValidator: constant.tvn_REGEX_ALL_CHARACTERS_EXCEPT_COMMA

    property color color_background_normal:     "#3b4351"
    property color color_background_hovered:    "#576075"
    property color color_text_normal:           "#e8e9e2"
    property color color_text_hovered:          "#fafbf9"
    property color color_border_normal:         color_text_normal
    property color color_border_hovered:        color_text_hovered

    signal inputChange(string text)

    height: 35
    radius: 5
    border.width: 1
    border.color: text_input.focus? color_border_hovered : color_border_normal
    color: text_input.focus? color_background_hovered : color_background_normal

    TextField
    {
        id: text_input

        width: parent.width
        text: ""
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 3
        horizontalAlignment: TextInput.AlignRight
        font.family: iranSansWeb.name
        font.pixelSize: 16
        selectByMouse: true
        validator: inputValidator
        background: Rectangle{color: "transparent"}
        color: focus? color_text_hovered: color_text_normal
        enabled: inputIsActive
        onAccepted: focus = false
        Keys.onEscapePressed: focus = false
        Keys.onEnterPressed: focus = false

        onFocusChanged:
        {
            if (focus)
            {
                text = ""
            }
            else
            {
                root.updateFocus()
            }
        }

        onTextEdited:
        {
            // convert persian number to english
            text = root.fa2en(text)
            inputChange(text)
        }
    }


    /*** Call this functions from qml ***/
    function clearInput()
    {
        text_input.text = ""
    }

    function getInput()
    {
        return text_input.text
    }
}

