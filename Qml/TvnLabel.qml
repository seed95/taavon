import QtQuick 2.0

Item
{

    property string labelText: ""
    property int labelFontSize: 0

    height: 45

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
