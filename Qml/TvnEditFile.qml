import QtQuick 2.10
import QtQuick.Window 2.10

Window
{
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
            list_file.forceActiveFocus()
            root.pageMode = constant.tvn_LIST_FILE
        }

        MouseArea
        {
            anchors.fill: parent
            onClicked: container.forceActiveFocus()
        }

        TvnDetail
        {
            id: detail
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 40
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
                onClickButton: console.log("delete file")
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
                onClickButton:
                {
                    root.saveChanges()
                }
            }

        }
    }

    function forceFocus()
    {
        container.forceActiveFocus()
    }
}
