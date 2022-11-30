import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.12

ApplicationWindow
{
    width: 945
    minimumWidth: width
    maximumWidth: width

    height: 415
    minimumHeight: height
    maximumHeight: height

    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    flags: Qt.WindowCloseButtonHint | Qt.CustomizeWindowHint | Qt.Dialog | Qt.WindowTitleHint
    title: "جزئیات پرونده" + " " + root.fileCode

    onVisibleChanged:
    {
        if (visible)
        {
            forceFocus()
        }
        else
        {
            root.pageMode = constant.tvn_LIST_FILE
        }
    }

    Rectangle
    {
        id: container

        width: parent.width
        height: parent.height
        color: "#2f343f"

        Keys.onEscapePressed:
        {
            file_list.forceActiveFocus()
            root.pageMode = constant.tvn_LIST_FILE
        }

        MouseArea
        {
            anchors.fill: parent
            onClicked: forceActiveFocus()
        }

        TvnDetail
        {
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 40
            fileCodeEnable: true
            readOnly: true
            containBackground: false
            objectName: "Detail"
        }

    }

    function forceFocus()
    {
        container.forceActiveFocus()
    }
}
