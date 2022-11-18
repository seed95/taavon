import QtQuick 2.0

Rectangle
{

    property string labelText: ""
    property int labelFontSize: 0

    height: 45
    color: "transparent"

    Text
    {
        anchors.centerIn: parent
        text: labelText
        font.family: iranSansWebMedium.name
        font.weight: Font.Medium
        font.pixelSize: labelFontSize
        color: "#e8e9e3"
    }

}
