import QtQuick 2.0
import QtQuick.Controls 2.5

Item {

    property string colorText: "#e8e9e3"
    property string positionText: ""
    property string nameText: ""
    property bool hasBottomLine: true
    property bool selectable: true

    height: 35
    width: 300

    Item
    {
        id: position
        width: 75
        height: parent.height
        anchors.right: parent.right

        Text
        {
            anchors.centerIn: parent
            text: positionText
            font.family: iranSansWeb.name
            font.pixelSize: 14
            color: colorText
        }
    }

    Rectangle
    {
        width: 1
        height: parent.height
        anchors.right: position.left
        anchors.rightMargin: -1
        color: "#e8e9e3"
    }

    TextField
    {
        id: first_name_last_name

        width: 225
        anchors.right: position.left
        anchors.verticalCenter: parent.verticalCenter
        text: nameText
        // TODO check 50
        horizontalAlignment: nameText.length>50 ? TextInput.AlignLeft:TextInput.AlignRight // 50 -> fix large contentText
        font.family: iranSansWeb.name
        font.pixelSize: 14
        selectByMouse: selectable
        readOnly: true
        clip: true
        background: Rectangle{color: "transparent"}
        color: colorText
        onAccepted: focus = false
        Keys.onEscapePressed: focus = false

    }


    Rectangle
    {
        width: parent.width
        height: 1
        color: "#e8e9e3"
        anchors.bottom: parent.bottom
        visible: hasBottomLine
    }

}
