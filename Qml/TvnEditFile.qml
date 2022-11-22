import QtQuick 2.0

Rectangle
{

    width: 945
    height: 415
    color: "#2f343f"
    radius: 5
    border.width: 2
    border.color: "#e8e9e3"

    TvnDetail
    {
        id: detail
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 40
        fileCodeReadOnly: true
        readOnly: false
        containBackground: true
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
        }

    }


}
