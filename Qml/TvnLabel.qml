import QtQuick 2.0

Item
{

    property string labelText:      ""
    property string labelFontName:  iranSansWebMedium.name
    property int labelFontWeight:   Font.Medium
    property int labelFontSize:     0
    property string labelColor:     "#e8e9e3"

    height: 45

    Text
    {
        anchors.centerIn: parent
        text: labelText
        font.family: labelFontName
        font.weight: labelFontWeight
        font.pixelSize: labelFontSize
        color: labelColor
    }

}
