import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.5

ApplicationWindow
{
    property int dialogType: constant.tvn_DIALOG_NOPE

    width: 945
    minimumWidth: width
    maximumWidth: width

    height: 450
    minimumHeight: height
    maximumHeight: height

    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    flags: Qt.WindowCloseButtonHint | Qt.CustomizeWindowHint | Qt.Dialog | Qt.WindowTitleHint
    title: "ویرایش پرونده" + " " + root.fileCode


    onVisibleChanged:
    {
        if (visible)
        {
            forceFocus()
            detail.updateTexts()
        }
    }

    onDialogTypeChanged: forceFocus()

    onClosing:
    {
        close.accepted = false
        closeWindow()
    }

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
            onClicked: container.forceActiveFocus()
        }

        TvnDetail
        {
            id: detail
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 40
            detailIsActive: windowIsActive()
            fileCodeEnable: false
            readOnly: false
            containBackground: true
            objectName: "Detail"
        }

        Item
        {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 18

            TvnButton
            {
                id: delete_btn
                width: 150
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                btnText: "حذف پرونده"
                btnIcon: "\uf1f8"
                textWidth: 105
                isActive: windowIsActive()
                onClickButton: console.log("delete")
            }

            TvnButton
            {
                id: save_btn
                width: 150
                anchors.bottom: parent.bottom
                anchors.left: delete_btn.right
                anchors.leftMargin: 28
                btnText: "ذخیره تغییرات"
                btnIcon: "\uf0c7"
                textWidth: 112
                isActive: windowIsActive()
                onClickButton: dialogType = constant.tvn_DIALOG_SAVE
            }

        }

        TvnDialog
        {
            id: save_dialog
            anchors.centerIn: parent
            visible: dialogType === constant.tvn_DIALOG_SAVE
            textLabel: "آیا از ذخیره تغییرات مطمین هستید؟"
            dialogIsActive: visible

            onClickPositive:
            {
                dialogType = constant.tvn_DIALOG_NOPE
                root.saveChanges()
            }
            onClickNegative: dialogType = constant.tvn_DIALOG_NOPE
        }

        TvnDialog
        {
            id: sure_dont_save_changes_dialog
            width: 600
            anchors.centerIn: parent
            visible: dialogType === constant.tvn_DIALOG_SURE_DONT_SAVE_CHANGES
            textLabel: "تغییراتی در پرونده انجام شده است. آیا می خواهید تغییرات ذخیره شود؟ "
            dialogIsActive: visible

            onClickPositive:
            {
                dialogType = constant.tvn_DIALOG_NOPE
                root.saveChanges()
            }
            onClickNegative:
            {
                root.hasChanged = false
                root.pageMode = constant.tvn_LIST_FILE
                dialogType = constant.tvn_DIALOG_NOPE
            }
        }

    }

    function closeWindow()
    {
        if (root.hasChanged)
        {
            dialogType = constant.tvn_DIALOG_SURE_DONT_SAVE_CHANGES
        }
        else
        {
            root.pageMode = constant.tvn_LIST_FILE
        }
    }

    function forceFocus()
    {
        if (dialogType===constant.tvn_DIALOG_NOPE)
        {
            container.forceActiveFocus()
        }
    }

    // It returns true if the dialog is not open and the program's focus is on this page
    function windowIsActive()
    {
        if (dialogType===constant.tvn_DIALOG_NOPE &&
            root.pageMode===constant.tvn_EDIT_FILE &&
            root.errorMessage==="")
        {
            return true
        }
        return false
    }

}
