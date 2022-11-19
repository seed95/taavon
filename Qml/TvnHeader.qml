import QtQuick 2.0

Rectangle {

    height: 36
    width: 1250
    color: "transparent"
//    color: "#00003b"


    property int normal_font_size: 14
    property int small_font_size: 12

    TvnHeaderLabel
    {
        id: file_code
        width: 70
        labelText: "کد پرونده"
        labelFontSize: normal_font_size
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }

    TvnHeaderLabel
    {
        id: keeping_place
        width: 113
        labelText: "محل نگهداری"
        labelFontSize: normal_font_size
        anchors.right: file_code.left
        anchors.verticalCenter: parent.verticalCenter
    }

    TvnHeaderLabel
    {
        id: status
        width: 82
        labelText: "وضعیت"
        labelFontSize: normal_font_size
        anchors.right: keeping_place.left
        anchors.verticalCenter: parent.verticalCenter
    }

    TvnHeaderLabel
    {
        id: ledger_binder
        width: 65
        labelText: "کد فایل"
        labelFontSize: small_font_size
        anchors.right: status.left
        anchors.verticalCenter: parent.verticalCenter
    }

    TvnHeaderLabel
    {
        id: number_of_cover
        width: 38
        labelText: "تعداد جلد"
        labelFontSize: small_font_size
        anchors.right: ledger_binder.left
        anchors.verticalCenter: parent.verticalCenter
    }

    TvnHeaderLabel
    {
        id: file_name
        width: 293
        labelText: "اسم پرونده"
        labelFontSize: normal_font_size
        anchors.right: number_of_cover.left
        anchors.verticalCenter: parent.verticalCenter
    }

    TvnHeaderLabel
    {
        id: registration_number
        width: 75
        labelText: "شماره ثبت"
        labelFontSize: normal_font_size
        anchors.right: file_name.left
        anchors.verticalCenter: parent.verticalCenter
    }

    TvnHeaderLabel
    {
        id: date_of_last_meeting
        width: 110
        labelText: "تاریخ آخرین مجمع"
        labelFontSize: small_font_size
        anchors.right: registration_number.left
        anchors.verticalCenter: parent.verticalCenter
    }

    TvnHeaderLabel
    {
        id: national_id
        width: 115
        labelText: "شناسه ملی"
        labelFontSize: normal_font_size
        anchors.right: date_of_last_meeting.left
        anchors.verticalCenter: parent.verticalCenter
    }

    TvnHeaderLabel
    {
        id: ceo_name
        width: 145
        labelText: "مدیر عامل"
        labelFontSize: normal_font_size
        anchors.right: national_id.left
        anchors.verticalCenter: parent.verticalCenter
    }

    TvnHeaderLabel
    {
        id: mobile_number
        width: 106
        labelText: "شماره موبایل"
        labelFontSize: normal_font_size
        anchors.right: ceo_name.left
        anchors.verticalCenter: parent.verticalCenter
    }


    Rectangle
    {
        id: line
        width: parent.width
        height: 2
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        color: "#e8e9e3"
    }

}
