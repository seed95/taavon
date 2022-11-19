import QtQuick 2.0

Item
{

    property string labelText: ""
    property int labelFontSize: 0

    height: 36

    Text
    {
        id: file_code
        text: labelText
        color: "#c5c74d"
        anchors.centerIn: parent
        font.family: iranSansWebBold.name
        font.weight: Font.Bold
        font.pixelSize: labelFontSize
    }

}
