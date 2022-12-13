import QtQuick 2.0

Item
{
    property bool searchIsActive: false


    width: 1250
    height: 45

    TvnSearchNumberBtn
    {
        id: file_code
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        isActive: searchIsActive
        titleText: "کد پرونده"
        inputWidth: 60
    }

    TvnSearchStringBtn
    {
        id: file_name
        anchors.right: file_code.left
        anchors.rightMargin: 30
        anchors.verticalCenter: parent.verticalCenter
        isActive: searchIsActive
        titleText: "اسم پرونده"
        inputWidth: 280
    }

    TvnSearchNumberBtn
    {
        id: registration_number
        anchors.right: file_name.left
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        isActive: searchIsActive
        titleText: "شماره ثبت"
        inputWidth: 70
    }

    // TODO use setting for selected items
    TvnComboBox
    {
        id: status
        width: 193
        anchors.right: registration_number.left
        anchors.rightMargin: 32
        anchors.verticalCenter: parent.verticalCenter
        comboIsActive: searchIsActive
        titleText: "وضعیت"
        comboWidth: 130
        textItems: root.statusItems
    }

    // TODO use setting for selected items
    TvnComboBox
    {
        id: keeping_palce
        width: 247
        anchors.right: status.left
        anchors.rightMargin: 30
        anchors.verticalCenter: parent.verticalCenter
        comboIsActive: searchIsActive
        titleText: "محل نگهداری"
        comboWidth: 160
        textItems: root.keepingPlaceItems
    }


}
