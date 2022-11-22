import QtQuick 2.0

Item
{
    id: continer

    property bool readOnly: false
    property bool containBackground: false
    property bool fileCodeEnable: false

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

        // TODO check input only number
        TvnDetailLabel
        {
            id: file_code
            width: 152
            anchors.right: parent.right
            anchors.top: parent.top
            titleText: "کد پرونده"
            contentText: root.fileCode
            contentReadOnly: true
            haveBackground: containBackground
            haveBorder: !readOnly
            alignCenter: !readOnly
            contentEnable: fileCodeEnable
            inputWidth: 65
        }

        TvnDetailLabel
        {
            id: status
            width: 193
            anchors.right: file_code.left
            anchors.top: parent.top
            titleText: "وضعیت"
            contentText: root.fileStatus
            inputWidth: 120
            visible: readOnly
        }

        TvnComboBox
        {
            id: combo_status
            width: 193
            anchors.right: file_code.left
            anchors.verticalCenter: parent.verticalCenter
            titleText: "وضعیت"
            headerText: root.fileStatus
            comboWidth: 120
            textItems: ["منحل", "غیر فعال","فعال","در دست اجرا"]
            singleChoice: true
            visible: !readOnly
            onChangeSelected: root.fileStatus = selectedItemText
        }

        TvnDetailLabel
        {
            id: keeping_place
            width: 252
            anchors.right: status.left
            anchors.top: parent.top
            titleText: "محل نگهداری"
            contentText: root.keepingPlace
            inputWidth: 120
            visible: readOnly
        }

        TvnComboBox
        {
            id: combo_keeping_place
            width: 247
            anchors.right: status.left
            anchors.verticalCenter: parent.verticalCenter
            titleText: "محل نگهداری"
            headerText: root.keepingPlace
            comboWidth: 145
            textItems: ["بایگانی/دایی", "نیست","دایی","بایگانی"]
            singleChoice: true
            visible: !readOnly
            onChangeSelected: root.fileStatus = selectedItemText
        }

        TvnDetailLabel
        {
            id: ledger_binder
            width: 140
            anchors.right: readOnly? keeping_place.left : combo_keeping_place.left
            anchors.top: parent.top
            titleText: "کد فایل"
            contentText: root.ledgerBinder
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 65
        }

        // TODO check input only number
        TvnDetailLabel
        {
            id: number_of_cover
            width: 125
            anchors.right: ledger_binder.left
            anchors.top: parent.top
            titleText: "تعداد جلد"
            contentText: root.numberOfCover
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
            contentText: root.fileName
            haveBorder: true
            contentReadOnly: readOnly
            haveBackground: containBackground
            contentFontSize: 15
            inputWidth: 285
        }

        // TODO check input only number
        TvnDetailLabel
        {
            id: registration_number
            width: 137
            anchors.right: file_name.left
            anchors.top: parent.top
            titleText: "شماره ثبت"
            contentText: root.registrationNumber
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
            contentText: root.dateOfRegistration
            contentFontSize: 17
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 105
        }

        // TODO check input only number
        TvnDetailLabel
        {
            id: national_id
            width: 192
            anchors.right: date_of_registration.left
            anchors.top: parent.top
            titleText: "شناسه ملی"
            contentText: root.nationalId
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
            contentText: root.dateOfLastMeeting
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

        // TODO check input only number
        TvnDetailLabel
        {
            id: number_of_primary_members
            width: 166
            anchors.right: parent.right
            anchors.rightMargin: 321
            anchors.top: parent.top
            titleText: "تعداد اعضاء اولیه"
            contentText: root.numberOfPrimaryMembers
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 35
        }

        // TODO check input only number
        TvnDetailLabel
        {
            id: number_of_current_members
            width: 166
            anchors.right: number_of_primary_members.left
            anchors.top: parent.top
            titleText: "تعداد اعضاء فعلی"
            contentText: root.numberOfCurrentMembers
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 35
        }

        // TODO check input only number and show with ,
        TvnDetailLabel
        {
            id: value_per_share
            width: 234
            anchors.right: number_of_current_members.left
            anchors.top: parent.top
            titleText: "ارزش هر سهم"
            parenthesesText: "ریال"
            contentText: root.valuePerShare
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

        // TODO check input only number and show with ,
        TvnDetailLabel
        {
            id: starting_capital
            width: 260
            anchors.right: parent.right
            anchors.rightMargin: 321
            anchors.top: parent.top
            titleText: "سرمایه اولیه"
            parenthesesText: "ریال"
            contentText: root.startingCapital
            contentReadOnly: readOnly
            haveBackground: containBackground
            alignCenter: false
            inputWidth: 138
        }

        // TODO check input only number and show with ,
        TvnDetailLabel
        {
            id: current_capital
            width: 306
            anchors.right: starting_capital.left
            anchors.rightMargin: 5
            anchors.top: parent.top
            titleText: "سرمایه فعلی"
            parenthesesText: "ریال"
            contentText: root.currentCapital
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

        // TODO check input only number
        TvnDetailLabel
        {
            id: phone_number
            width: 273
            anchors.right: parent.right
            anchors.rightMargin: 321
            anchors.top: parent.top
            titleText: "شماره تلفن ثابت"
            contentText: root.phoneNumber
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 144
        }

        // TODO check input only number
        TvnDetailLabel
        {
            id: mobile_number
            width: 242
            anchors.right: phone_number.left
            anchors.top: parent.top
            titleText: "شماره موبایل"
            contentText: root.mobileNumber
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
            haveBorder: true
            contentText: root.officeAddress
            contentReadOnly: readOnly
            haveBackground: containBackground
            contentFontSize: 15
            alignCenter: false
            inputWidth: 521
        }
    }

    TvnTable
    {
        anchors.right: parent.right
        anchors.top: row3.bottom
        anchors.topMargin: 7
        ceoName: root.ceoName
        chairmanName: root.chairmanName
        viceName: root.viceName
        secretaryName: root.secretaryName
        readOnlyTable: readOnly
    }
}
