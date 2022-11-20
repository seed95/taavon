import QtQuick 2.0

Rectangle {

    width: 945
    height: 415
    color: "#2f343f"
    radius: 5
    border.width: 2
    border.color: "#e8e9e3"

    Item
    {
        id: row1
        height: 45
        width: 902
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 5

        TvnDetailLabel
        {
            id: file_code
            width: 152
            anchors.right: parent.right
            anchors.top: parent.top
            titleText: "کد پرونده"
            contentText: "127"
            contentFontSize: 16
        }

        TvnDetailLabel
        {
            id: status
            width: 218
            anchors.right: file_code.left
            anchors.top: parent.top
            titleText: "وضعیت"
            contentText: "در دست اجرا"
            contentFontSize: 16
        }

        TvnDetailLabel
        {
            id: keeping_place
            width: 252
            anchors.right: status.left
            anchors.top: parent.top
            titleText: "محل نگهداری"
            contentText: "بایگانی/دایی"
            contentFontSize: 16
        }

        TvnDetailLabel
        {
            id: ledger_binder
            width: 165
            anchors.right: keeping_place.left
            anchors.top: parent.top
            titleText: "کد فایل"
            contentText: "زونکن"
            contentFontSize: 16
        }

        TvnDetailLabel
        {
            id: number_of_cover
            width: 100
            anchors.right: ledger_binder.left
            anchors.top: parent.top
            titleText: "تعداد جلد"
            contentText: "2"
            contentFontSize: 16
        }
    }

    Item
    {
        id: row2
        height: 45
        width: 902
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.top: row1.bottom

        TvnDetailLabel
        {
            id: registration_number
            width: 127
            anchors.right: parent.right
            anchors.top: parent.top
            titleText: "شماره ثبت"
            contentText: "1059"
            contentFontSize: 16
        }

        TvnDetailLabel
        {
            id: date_of_registration
            width: 185
            anchors.right: registration_number.left
            anchors.top: parent.top
            titleText: "تاریخ ثبت"
            contentText: "1395/05/06"
            contentFontSize: 16
        }

        TvnDetailLabel
        {
            id: national_id
            width: 195
            anchors.right: date_of_registration.left
            anchors.top: parent.top
            titleText: "شناسه ملی"
            contentText: "10260157312"
            contentFontSize: 16
        }

        TvnDetailLabel
        {
            id: file_name
            width: 380
            anchors.right: national_id.left
            anchors.top: parent.top
            titleText: "اسم پرونده"
            contentText: "توسعه و عمران زینبیه یزدل"
            contentFontSize: 16
        }
    }

    Item
    {
        id: row3
        height: 45
        width: 902
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.top: row2.bottom

        TvnDetailLabel
        {
            id: date_of_last_meeting
            width: 260
            anchors.right: parent.right
            anchors.top: parent.top
            titleText: "تاریخ آخرین مجمع"
            contentText: "1395/05/06"
            contentFontSize: 16
        }

        TvnDetailLabel
        {
            id: number_of_members
            width: 166
            anchors.right: date_of_last_meeting.left
            anchors.top: parent.top
            titleText: "تعداد اعضاء"
            contentText: "7" + " نفر"
            contentFontSize: 16
        }

        TvnDetailLabel
        {
            id: last_registered_capital
            width: 321
            anchors.right: number_of_members.left
            anchors.top: parent.top
            titleText: "آخرین سرمایه ثبتی"
            contentText: "100230000" + "تومان"
            contentFontSize: 16
        }

        TvnDetailLabel
        {
            id: year_of_dissolution
            width: 140
            anchors.right: last_registered_capital.left
            anchors.top: parent.top
            titleText: "سال انحلال"
            contentText: "1400"
            contentFontSize: 16
        }
    }
}
