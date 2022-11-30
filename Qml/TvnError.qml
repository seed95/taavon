import QtQuick 2.10
import QtQuick.Window 2.10

Window
{
    width: 300
    minimumWidth: width
    maximumWidth: width

    height: 100
    minimumHeight: height
    maximumHeight: height

    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    flags: Qt.WindowCloseButtonHint | Qt.CustomizeWindowHint | Qt.Dialog | Qt.WindowTitleHint
    title: "خطا"

    onVisibleChanged:
    {
        if (visible)
        {
            forceFocus()
        }
        else
        {
            root.updateFocus()
        }
    }

    Rectangle
    {
        id: container

        width: parent.width
        height: parent.height
        color: "#2d2d2d"

        Keys.onEscapePressed:
        {
            root.errorMessage = ""
            root.updateFocus()
        }

        MouseArea
        {
            anchors.fill: parent
            onClicked: container.forceActiveFocus()
        }

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

        Text
        {
            id: message
            anchors.right: error.right
            anchors.top: error.bottom
            anchors.topMargin: 10
            text: root.errorMessage
            font.pixelSize: 17
            font.family: iranSansWeb.name
            color: "#ffffff"
        }

    }

    function forceFocus()
    {
        container.forceActiveFocus()
    }
}
