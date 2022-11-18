import QtQuick 2.0

Rectangle
{
    color: "#00003b"
//    color: "transparent"
    width: 1247
    height: 45

    TvnSearchBtn
    {
        id: file_code
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        titleText: "کد پرونده"
        inputWidth: 68
    }

    TvnComboBox
    {
        id: state
//        width: 130
        height: 34
        anchors.left: parent.left
        anchors.leftMargin: 100
        anchors.verticalCenter: parent.verticalCenter
        titleText: "وضعیت"
        comboWidth: 100
    }

}