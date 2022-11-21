import QtQuick 2.0
import QtQuick.Controls 2.5

Item {

    property string titleText: ""
    property string contentText: ""
    property int contentFontSize: 0
    property bool haveBorder: false

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

    Rectangle
    {
        height: 35
        anchors.right: title.left
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        radius: 5
        border.width: 1
        border.color: haveBorder? "#e8e9e2":"transparent"
        color: "transparent"

        TextField
        {
            id: content

            width: parent.width
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            text: contentText
            horizontalAlignment: contentText.length>50 ? TextInput.AlignLeft:TextInput.AlignRight // 50 -> fix large contentText
            font.family: iranSansWeb.name
            font.pixelSize: contentFontSize
            selectByMouse: true
            readOnly: true
            clip: true
            background: Rectangle{color: "transparent"}
            color: "#e8e9e2"
            onAccepted: focus = false
            Keys.onEscapePressed: focus = false

        }
    }

}
