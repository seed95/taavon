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
    }

    onClosing: closeWindow()

    Rectangle
    {
        id: container

        width: parent.width
        height: parent.height
        color: "#2f343f"

        Keys.onEscapePressed:
        {
            if (windowIsActive())
            {
                closeWindow()
            }
        }

        MouseArea
        {
            anchors.fill: parent
            enabled: windowIsActive()
            onClicked: forceActiveFocus()
        }

        TvnDetail
        {
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 40
            detailIsActive: windowIsActive()
            fileCodeEnable: true
            readOnly: true
            containBackground: false
            objectName: "Detail"
        }

    }

    function closeWindow()
    {
        root.pageMode = constant.tvn_LIST_FILE
    }

    function forceFocus()
    {
        container.forceActiveFocus()
    }

    // It returns true if the program's focus is on this page
    function windowIsActive()
    {
        if (root.pageMode===constant.tvn_VIEW_FILE && root.errorMessage==="")
        {
            return true
        }
        return false
    }

}
