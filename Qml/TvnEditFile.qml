import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.5

ApplicationWindow
{
    property int dialogType: constant.tvn_DIALOG_NOPE
    property string errorMessage: ""

    // cpp signals
    signal saveChanges()
    signal cancelSaveChanges()
    signal deleteImages()
    signal uploadImages()
//    signal cancelUpload()
//    signal cancelDelete()

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
            root.hasChanged = false
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
                isActive: windowIsActive()
                onClickButton: dialogType = constant.tvn_DIALOG_SAVE
            }

        }

        TvnDialog
        {
            id: save_dialog
            anchors.centerIn: parent
            textLabel: "آیا از ذخیره تغییرات مطمین هستید؟"
            positiveText: "بله"
            positiveWidth: 60
            negativeText: "خیر"
            negativeWidth: 60
            visible: dialogType === constant.tvn_DIALOG_SAVE
            dialogIsActive: visible

            onClickPositive: saveFileChanges()
            onClickNegative: dialogType = constant.tvn_DIALOG_NOPE
        }

        TvnDialog
        {
            id: sure_dont_save_changes_dialog
            width: 600
            anchors.centerIn: parent
            textLabel: "تغییراتی در پرونده انجام شده است. آیا می خواهید تغییرات ذخیره شود؟ "
            positiveText: "بله"
            positiveWidth: 60
            negativeText: "خیر"
            negativeWidth: 60
            visible: dialogType === constant.tvn_DIALOG_SURE_DONT_SAVE_CHANGES
            dialogIsActive: visible

            onClickPositive: saveFileChanges()
            onClickNegative:
            {
                root.pageMode = constant.tvn_LIST_FILE
                dialogType = constant.tvn_DIALOG_NOPE
            }
        }

        TvnDialog
        {
            id: save_changes
            anchors.centerIn: parent
            textLabel: "در حال ذخیره تغییرات"
            width: 300
            height: 100
//            negativeText: "انصراف"
//            negativeWidth: 80
            visible: dialogType === constant.tvn_DIALOG_SAVE_CHANGES
//            dialogIsActive: visible

//            onClickNegative: cancelSaveChanges()
        }

//        TvnDialog
//        {
//            id: upload_dialog
//            anchors.centerIn: parent
//            textLabel: "در حال آپلود عکس"
//            negativeText: "انصراف"
//            negativeWidth: 80
//            visible: dialogType === constant.tvn_DIALOG_UPLOAD
//            dialogIsActive: visible

//            onClickNegative: cancelUpload()
//        }

//        TvnDialog
//        {
//            id: delete_dialog
//            anchors.centerIn: parent
//            textLabel: "در حال حذف عکس"
//            negativeText: "انصراف"
//            negativeWidth: 80
//            visible: dialogType === constant.tvn_DIALOG_DELETE
//            dialogIsActive: visible

//            onClickNegative: cancelDelete()
//        }


        TvnError
        {
            anchors.centerIn: parent
            messageText: errorMessage
            visible: errorMessage !== ""
            onClickOk: errorMessage = ""
        }

    }

    /*** Call this functions from qml ***/
    function closeWindow()
    {
        // do nothing if another dialog is open
        if (dialogType!==constant.tvn_DIALOG_NOPE)
        {
            return
        }

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

    function saveFileChanges()
    {
        dialogType = constant.tvn_DIALOG_SAVE_CHANGES
        root.processType = constant.tvn_PROCESS_IMAGE_REMOVE
        deleteImages()
    }


    /*** Call this functions from cpp ***/
//    function showUploadDialog()
//    {
//        dialogType = constant.tvn_DIALOG_UPLOAD
//    }

//    function showDeleteDialog()
//    {
//        dialogType = constant.tvn_DIALOG_DELETE
//    }

    function deleteImagesSuccessfully()
    {
        root.processType = constant.tvn_PROCESS_IMAGE_UPLOAD
        uploadImages()
    }

    function uploadImagesSuccessfully()
    {
        root.processType = constant.tvn_PROCESS_UPLOAD_CSV
        saveChanges()
    }

    function saveChangesSuccessfully()
    {
        list.updateFile()
        dialogType = constant.tvn_DIALOG_NOPE
        root.processType = constant.tvn_PROCESS_NOPE
        root.pageMode = constant.tvn_LIST_FILE
    }

    function hideDialog()
    {
        dialogType = constant.tvn_DIALOG_NOPE
        root.processType = constant.tvn_PROCESS_NOPE
    }


}
