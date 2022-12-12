import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.5

Rectangle
{
    id: container

    property string messageText: ""

    width: message.contentWidth>150? message.contentWidth + 150 : 200
    height: 150
    color: "#2d2d2d"
    border.color: "#808080"
    border.width: 3
    radius: 15

    signal clickOk()

    Text
    {
        id: error
        anchors.right: parent.right
        anchors.rightMargin: 15
        anchors.topMargin: 15
        anchors.top: parent.top
        text: "خطا"
        font.pixelSize: 23
        font.family: iranSansWebBold.name
        font.weight: Font.Bold
        color: "#ffffff"
    }

    Text
    {
        id: icon
        anchors.left: parent.left
        anchors.top: error.top
        anchors.leftMargin: 15
        text: "\uf071"
        font.pixelSize: 25
        font.family: fontAwesomeSolid.name
        font.weight: Font.Bold
        color: "#fadf15"
    }

    TextField
    {
        id: message

        anchors.right: error.right
        anchors.top: error.bottom
        anchors.topMargin: 2
        text: container.messageText
        horizontalAlignment: TextInput.AlignRight
        font.family: iranSansWeb.name
        font.pixelSize: 17
        selectByMouse: true
        readOnly: true
        background: Rectangle{color: "transparent"}
        color: "#ffffff"
    }

    TvnButton
    {
        width: 80
        anchors.left: icon.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        btnText: "ok"
        isActive: true
        onClickButton: clickOk()
    }

}
