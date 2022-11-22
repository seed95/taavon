import QtQuick 2.0

Rectangle
{
    width: 1250
    height: 45
    color: "transparent"

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
        anchors.rightMargin: 30
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

    TvnComboBox
    {
        id: status
        width: 193
        anchors.right: registration_number.left
        anchors.rightMargin: 32
        anchors.verticalCenter: parent.verticalCenter
        titleText: "وضعیت"
        comboWidth: 130
        textItems: ["منحل", "غیر فعال","فعال","در دست اجرا"]
        onChangeSelected: headerText = selectedItemText
    }

    TvnComboBox
    {
        id: ledger_binder
        width: 247
        anchors.right: status.left
        anchors.rightMargin: 30
        anchors.verticalCenter: parent.verticalCenter
        titleText: "محل نگهداری"
        comboWidth: 160
        textItems: ["بایگانی/دایی", "نیست","دایی","بایگانی"]
        onChangeSelected: headerText = selectedItemText
    }


}
