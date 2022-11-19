import QtQuick 2.0

Rectangle
{
    width: 1250
    height: 45
    color: "transparent"
//    color: "#00003b"

    TvnSearchNumberBtn
    {
        id: file_code
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        titleText: "کد پرونده"
        inputWidth: 60
    }

    TvnSearchStringBtn
    {
        id: file_name
        anchors.right: file_code.left
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        titleText: "اسم پرونده"
        inputWidth: 280
    }

    TvnSearchNumberBtn
    {
        id: registration_number
        anchors.right: file_name.left
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        titleText: "شماره ثبت"
        inputWidth: 70
    }

//    TvnComboBox
//    {
//        id: state
////        width: 130
//        height: 34
//        anchors.left: parent.left
//        anchors.leftMargin: 100
//        anchors.verticalCenter: parent.verticalCenter
//        titleText: "وضعیت"
//        comboWidth: 100
//    }

}
