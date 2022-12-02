import QtQuick 2.0

Rectangle
{
    id: container

    property bool dialogIsActive: false
    property string textLabel: ""
    property string positiveText: "بله"
    property string negativeText: "خیر"

    signal clickNegative()
    signal clickPositive()


    width: 500
    height: 150
    color: "#2d2d2d"
    border.color: "#808080"
    border.width: 3
    radius: 15

    onVisibleChanged:
    {
        if (visible)
        {
            container.forceActiveFocus()
        }
    }

    Text
    {
        id: label
        anchors.right: parent.right
        anchors.rightMargin: 15
        anchors.top: parent.top
        anchors.topMargin: 25
        text: textLabel
        font.pixelSize: 16
        font.family: iranSansWeb.name
        color: "#ffffff"
    }

    Item
    {
        height: 40
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: 25
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15

        TvnButton
        {
            id: negative
            width: 80
            height: 30
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            btnText: negativeText
            textWidth: 28
            isActive: dialogIsActive

            onClickButton: clickNegative()
        }

        TvnButton
        {
            width: 80
            height: 30
            anchors.left: negative.right
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            btnText: positiveText
            textWidth: 28
            isActive: dialogIsActive

            onClickButton: clickPositive()
        }
    }

}
