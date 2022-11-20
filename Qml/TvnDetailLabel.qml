import QtQuick 2.0

Item {

    property string titleText: ""
    property string contentText: ""
    property int contentFontSize: 0

    height: 45

    Text
    {
        id: title
        text: titleText + ":"
        color: "#c5c74d"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        font.family: iranSansWebBold.name
        font.weight: Font.Bold
        font.pixelSize: 14
    }

    Text
    {
        id: content
        text: contentText
        color: "#e8e9e3"
        anchors.right: title.left
        anchors.rightMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        font.family: iranSansWeb.name
        font.pixelSize: contentFontSize
    }


}
