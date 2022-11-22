import QtQuick 2.0

Item
{
    id: continer

    property bool readOnly: false
    property bool containBackground: false
    property bool fileCodeReadOnly: false


    width: 887
    height: 325

    Item
    {
        id: row1
        height: 45
        width: parent.width
        anchors.right: parent.right
        anchors.top: parent.top
        z: 1

        TvnDetailLabel
        {
            id: file_code
            width: 152
            anchors.right: parent.right
            anchors.top: parent.top
            titleText: "کد پرونده"
            contentText: fileCode
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 65
        }


        TvnComboBox
        {
            id: status
            width: 193
            anchors.right: file_code.left
            anchors.verticalCenter: parent.verticalCenter
            titleText: "وضعیت"
            headerText: fileStatus
            comboWidth: 130
            textItems: ["منحل", "غیر فعال","فعال","در دست اجرا"]
        }

        TvnDetailLabel
        {
            id: keeping_place
            width: 252
            anchors.right: status.left
            anchors.top: parent.top
            titleText: "محل نگهداری"
            contentText: "بایگانی/دایی"
            inputWidth: 120
        }

        TvnDetailLabel
        {
            id: ledger_binder
            width: 140
            anchors.right: keeping_place.left
            anchors.top: parent.top
            titleText: "کد فایل"
            contentText: ledgerBinder
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 65
        }

        TvnDetailLabel
        {
            id: number_of_cover
            width: 125
            anchors.right: ledger_binder.left
            anchors.top: parent.top
            titleText: "تعداد جلد"
            contentText: numberOfCover
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 35
        }
    }

    Item
    {
        id: row2
        height: 45
        width: parent.width
        anchors.right: parent.right
        anchors.top: row1.bottom

        TvnDetailLabel
        {
            id: file_name
            width: 370

            anchors.right: parent.right
            anchors.top: parent.top
            titleText: "اسم پرونده"
            contentText: fileName
            haveBorder: true
            contentReadOnly: readOnly
            haveBackground: containBackground
            contentFontSize: 15
            inputWidth: 285
        }

        TvnDetailLabel
        {
            id: registration_number
            width: 137
            anchors.right: file_name.left
            anchors.top: parent.top
            titleText: "شماره ثبت"
            contentText: registrationNumber
            contentFontSize: 17
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 50
        }

        TvnDetailLabel
        {
            id: date_of_registration
            width: 188
            anchors.right: registration_number.left
            anchors.top: parent.top
            titleText: "تاریخ ثبت"
            contentText: dateOfRegistration
            contentFontSize: 17
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 105
        }

        TvnDetailLabel
        {
            id: national_id
            width: 192
            anchors.right: date_of_registration.left
            anchors.top: parent.top
            titleText: "شناسه ملی"
            contentText: nationalId
            contentFontSize: 17
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 112
        }

    }

    Item
    {
        id: row3
        height: 45
        width: parent.width
        anchors.right: parent.right
        anchors.top: row2.bottom

        TvnDetailLabel
        {
            id: date_of_last_meeting
            width: 260
            anchors.right: parent.right
            anchors.top: parent.top
            titleText: "تاریخ آخرین مجمع"
            contentText: dateOfLastMeeting
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 115
        }
    }

    Item
    {
        id: row4
        height: 45
        width: parent.width
        anchors.right: parent.right
        anchors.top: row3.bottom

        TvnDetailLabel
        {
            id: number_of_primary_members
            width: 166
            anchors.right: parent.right
            anchors.rightMargin: 321
            anchors.top: parent.top
            titleText: "تعداد اعضاء اولیه"
            contentText: numberOfPrimaryMembers
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 35
        }

        TvnDetailLabel
        {
            id: number_of_current_members
            width: 166
            anchors.right: number_of_primary_members.left
            anchors.top: parent.top
            titleText: "تعداد اعضاء فعلی"
            contentText: numberOfCurrentMembers
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 35
        }

        TvnDetailLabel
        {
            id: value_per_share
            width: 234
            anchors.right: number_of_current_members.left
            anchors.top: parent.top
            titleText: "ارزش هر سهم"
            parenthesesText: "ریال"
            contentText: valuePerShare
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 107
        }
    }

    Item
    {
        id: row5
        height: 45
        width: parent.width
        anchors.right: parent.right
        anchors.top: row4.bottom

        TvnDetailLabel
        {
            id: starting_capital
            width: 260
            anchors.right: parent.right
            anchors.rightMargin: 321
            anchors.top: parent.top
            titleText: "سرمایه اولیه"
            parenthesesText: "ریال"
            contentText: startingCapital
            contentReadOnly: readOnly
            haveBackground: containBackground
            alignCenter: false
            inputWidth: 138
        }

        TvnDetailLabel
        {
            id: current_capital
            width: 306
            anchors.right: starting_capital.left
            anchors.rightMargin: 5
            anchors.top: parent.top
            titleText: "سرمایه فعلی"
            parenthesesText: "ریال"
            contentText: currentCapital
            contentReadOnly: readOnly
            haveBackground: containBackground
            alignCenter: false
            inputWidth: 181
        }
    }

    Item
    {
        id: row6
        height: 45
        width: parent.width
        anchors.right: parent.right
        anchors.top: row5.bottom

        TvnDetailLabel
        {
            id: phone_number
            width: 273
            anchors.right: parent.right
            anchors.rightMargin: 321
            anchors.top: parent.top
            titleText: "شماره تلفن ثابت"
            contentText: phoneNumber
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 144
        }

        TvnDetailLabel
        {
            id: mobile_number
            width: 242
            anchors.right: phone_number.left
            anchors.top: parent.top
            titleText: mobileNumber
            contentText: "09123456789"
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 144
        }
    }

    Item
    {
        id: row7
        height: 45
        width: parent.width
        anchors.right: parent.right
        anchors.top: row6.bottom

        TvnDetailLabel
        {
            id: address
            width: 566
            anchors.right: parent.right
            anchors.rightMargin: 321
            anchors.top: parent.top
            titleText: "آدرس"
            contentText: officeAddress
            contentReadOnly: readOnly
            haveBackground: containBackground
            contentFontSize: 15
            alignCenter: false
            inputWidth: 521
        }
    }

    TvnTable
    {
        ceoName: root.ceoName
        chairmanName: root.chairmanName
        viceName: root.viceName
        secretaryName: root.secretaryName
        anchors.right: parent.right
        anchors.top: row3.bottom
        anchors.topMargin: 7
    }
}
