import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.12

ApplicationWindow
{
    property int dialogType: constant.tvn_DIALOG_NOPE
    property string errorMessage: ""

    signal cancelDownload()

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
            console.log("visible view file")
            detail.updateTexts()
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
            id: detail
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

        TvnDialog
        {
            id: download_dialog
            anchors.centerIn: parent
            textLabel: "در حال دانلود عکس"
            negativeText: "انصراف"
            negativeWidth: 80
            visible: dialogType === constant.tvn_DIALOG_DOWNLOAD
            dialogIsActive: visible

            onClickNegative: cancelDownload()
        }

        TvnError
        {
            anchors.centerIn: parent
            messageText: errorMessage
            visible: errorMessage !== ""
            onClickOk: errorMessage = ""
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
        if (dialogType===constant.tvn_DIALOG_NOPE &&
            root.pageMode===constant.tvn_VIEW_FILE)
        {
            return true
        }
        return false
    }

    function showDownloadDialog()
    {
        dialogType = constant.tvn_DIALOG_DOWNLOAD
    }

    function hideDialog()
    {
        dialogType = constant.tvn_DIALOG_NOPE
        root.processType = constant.tvn_PROCESS_NOPE
    }

}
