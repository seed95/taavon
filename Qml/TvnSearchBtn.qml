import QtQuick 2.0
import QtQuick.Controls 2.5


Item
{
    property bool isActive: false
    property string titleText: ""
    property int inputWidth: 0
    property var labelValidator: constant.tvn_REGEX_ALL_CHARACTERS_EXCEPT_COMMA

    signal textChange(string text)

    height: 45
    width: title.contentWidth + input.width + input.anchors.rightMargin

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

    TvnSearchTextInput
    {
        id: input
        width: inputWidth
        anchors.right: title.left
        anchors.rightMargin: 9
        anchors.verticalCenter: parent.verticalCenter
        inputIsActive: isActive
        inputValidator: labelValidator
        onInputChange: textChange(text)
    }

    /*** Call this functions from qml ***/
    function clearInput()
    {
        input.clearInput()
    }

    function getInput()
    {
        return input.getInput()
    }

}
