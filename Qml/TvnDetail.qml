import QtQuick 2.0

Item
{
    id: continer

    property bool detailIsActive: false
    property bool readOnly: false // used for view mode
    property bool containBackground: false
    property bool fileCodeEnable: false

    width: 887
    height: 370

    onVisibleChanged: console.log("visible")

    Item
    {
        id: row1
        height: 45
        width: parent.width
        anchors.right: parent.right
        anchors.top: parent.top
        z: 1 // TO show combo box

        TvnDetailLabel
        {
            id: file_code
            width: 152
            anchors.right: parent.right
            anchors.top: parent.top
            labelIsActive: detailIsActive
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
            labelIsActive: detailIsActive
            titleText: "وضعیت"
            contentText: root.fileStatus
            inputWidth: 120
            visible: readOnly
            onChangeItem: root.fileStatus = text
        }

        TvnComboBox
        {
            id: combo_status
            width: 193
            anchors.right: file_code.left
            anchors.verticalCenter: parent.verticalCenter
            comboIsActive: detailIsActive
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
            labelIsActive: detailIsActive
            titleText: "محل نگهداری"
            contentText: root.keepingPlace
            inputWidth: 120
            visible: readOnly
            onChangeItem: root.keepingPlace = text
        }

        TvnComboBox
        {
            id: combo_keeping_place
            width: 247
            anchors.right: status.left
            anchors.verticalCenter: parent.verticalCenter
            comboIsActive: detailIsActive
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
            labelIsActive: detailIsActive
            titleText: "کد فایل"
            contentText: root.ledgerBinder
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 65
            onChangeItem: root.ledgerBinder = text
        }

        TvnDetailLabel
        {
            id: number_of_cover
            width: 125
            anchors.right: ledger_binder.left
            anchors.top: parent.top
            labelIsActive: detailIsActive
            titleText: "تعداد جلد"
            contentText: root.numberOfCover
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 35
            onChangeItem: root.numberOfCover = text
            labelValidator: IntValidator {bottom: 1; top: 10; locale: "fa"}
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
            labelIsActive: detailIsActive
            titleText: "اسم پرونده"
            contentText: root.fileName
            haveBorder: true
            contentReadOnly: readOnly
            haveBackground: containBackground
            contentFontSize: 15
            inputWidth: 285
            onChangeItem: root.fileName = text
        }

        // TODO check input size
        TvnDetailLabel
        {
            id: registration_number
            width: 137
            anchors.right: file_name.left
            anchors.top: parent.top
            labelIsActive: detailIsActive
            titleText: "شماره ثبت"
            contentText: root.registrationNumber
            contentFontSize: 17
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 50
            onChangeItem: root.registrationNumber = text
            labelValidator: IntValidator {bottom: 1; top: 9999; locale: "fa"}
        }

        TvnDetailLabel
        {
            id: date_of_registration
            width: 188
            anchors.right: registration_number.left
            anchors.top: parent.top
            labelIsActive: detailIsActive
            titleText: "تاریخ ثبت"
            contentText: root.dateOfRegistration
            contentFontSize: 17
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 105
            onChangeItem: root.dateOfRegistration = text
        }

        // TODO check input size
        TvnDetailLabel
        {
            id: national_id
            width: 192
            anchors.right: date_of_registration.left
            anchors.top: parent.top
            labelIsActive: detailIsActive
            titleText: "شناسه ملی"
            contentText: root.nationalId
            contentFontSize: 17
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 112
            onChangeItem: root.nationalId = text
            labelValidator: RegExpValidator { regExp: /\d{11}/ }
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
            labelIsActive: detailIsActive
            titleText: "تاریخ آخرین مجمع"
            contentText: root.dateOfLastMeeting
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 115
            onChangeItem: root.dateOfLastMeeting = text
        }
    }

    Item
    {
        id: row4
        height: 45
        width: parent.width
        anchors.right: parent.right
        anchors.top: row3.bottom

        // TODO check input size
        TvnDetailLabel
        {
            id: number_of_primary_members
            width: 166
            anchors.right: parent.right
            anchors.rightMargin: 321
            anchors.top: parent.top
            labelIsActive: detailIsActive
            titleText: "تعداد اعضاء اولیه"
            contentText: root.numberOfPrimaryMembers
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 35
            onChangeItem: root.numberOfPrimaryMembers = text
            labelValidator: IntValidator {bottom: 1; top: 100; locale: "fa"}
        }

        TvnDetailLabel
        {
            id: number_of_current_members
            width: 166
            anchors.right: number_of_primary_members.left
            anchors.top: parent.top
            labelIsActive: detailIsActive
            titleText: "تعداد اعضاء فعلی"
            contentText: root.numberOfCurrentMembers
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 35
            onChangeItem: root.numberOfCurrentMembers = text
            labelValidator: IntValidator {bottom: 1; top: 100; locale: "fa"}
        }

        // TODO show with ,
        TvnDetailLabel
        {
            id: value_per_share
            width: 234
            anchors.right: number_of_current_members.left
            anchors.top: parent.top
            labelIsActive: detailIsActive
            titleText: "ارزش هر سهم"
            parenthesesText: "ریال"
            contentText: root.valuePerShare
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 107
            onChangeItem: root.valuePerShare = text
            labelValidator: RegExpValidator { regExp: /^\d*$/ }
        }
    }

    Item
    {
        id: row5
        height: 45
        width: parent.width
        anchors.right: parent.right
        anchors.top: row4.bottom

        // TODO show with ,
        TvnDetailLabel
        {
            id: starting_capital
            width: 260
            anchors.right: parent.right
            anchors.rightMargin: 321
            anchors.top: parent.top
            labelIsActive: detailIsActive
            titleText: "سرمایه اولیه"
            parenthesesText: "ریال"
            contentText: root.startingCapital
            contentReadOnly: readOnly
            haveBackground: containBackground
            alignCenter: false
            inputWidth: 138
            onChangeItem: root.startingCapital = text
            labelValidator: RegExpValidator { regExp: /^\d*$/ }
        }

        // TODO show with ,
        TvnDetailLabel
        {
            id: current_capital
            width: 306
            anchors.right: starting_capital.left
            anchors.rightMargin: 5
            anchors.top: parent.top
            labelIsActive: detailIsActive
            titleText: "سرمایه فعلی"
            parenthesesText: "ریال"
            contentText: root.currentCapital
            contentReadOnly: readOnly
            haveBackground: containBackground
            alignCenter: false
            inputWidth: 181
            onChangeItem: root.currentCapital = text
            labelValidator: RegExpValidator { regExp: /^\d*$/ }
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
            labelIsActive: detailIsActive
            titleText: "شماره تلفن ثابت"
            contentText: root.phoneNumber
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 144
            onChangeItem: root.phoneNumber = text
            labelValidator: RegExpValidator { regExp: /\d{11}/ }
        }

        TvnDetailLabel
        {
            id: mobile_number
            width: 242
            anchors.right: phone_number.left
            anchors.top: parent.top
            labelIsActive: detailIsActive
            titleText: "شماره موبایل"
            contentText: root.mobileNumber
            contentReadOnly: readOnly
            haveBackground: containBackground
            inputWidth: 144
            onChangeItem: root.mobileNumber = text
            labelValidator: RegExpValidator { regExp: /09\d{9}/ }
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
            labelIsActive: detailIsActive
            titleText: "آدرس"
            haveBorder: true
            contentText: root.officeAddress
            contentReadOnly: readOnly
            haveBackground: containBackground
            contentFontSize: 15
            alignCenter: false
            inputWidth: 521
            onChangeItem: root.officeAddress = text
        }
    }

    TvnTable
    {
        id: table
        anchors.right: parent.right
        anchors.top: row3.bottom
        anchors.topMargin: 7
        ceoName: root.ceoName
        chairmanName: root.chairmanName
        viceName: root.viceName
        secretaryName: root.secretaryName
        readOnlyTable: readOnly
        tableIsActive: detailIsActive
    }

    TvnDetailImage
    {
        width: parent.width
        anchors.right: parent.right
        anchors.top: table.bottom
        anchors.topMargin: 15
        objectName: "DetailImage"

        imageIsActive: detailIsActive
        extraordinaryHasImage: root.extraordinaryMeetingHasImage
        generalHasImage: root.generalMeetingHasImage
        licenceHasImage: root.licenceHasImage
        registrationHasImage: root.registrationAdHasImage
    }

    function updateTexts()
    {
        file_code.updateText(root.fileCode)
        status.updateText(root.fileStatus)
        keeping_place.updateText(root.keepingPlace)
        ledger_binder.updateText(root.ledgerBinder)
        number_of_cover.updateText(root.numberOfCover)
        file_name.updateText(root.fileName)
        registration_number.updateText(root.registrationNumber)
        date_of_registration.updateText(root.dateOfRegistration)
        national_id.updateText(root.nationalId)
        date_of_last_meeting.updateText(root.dateOfLastMeeting)
        number_of_primary_members.updateText(root.numberOfPrimaryMembers)
        number_of_current_members.updateText(root.numberOfCurrentMembers)
        value_per_share.updateText(root.valuePerShare)
        starting_capital.updateText(root.startingCapital)
        current_capital.updateText(root.currentCapital)
        phone_number.updateText(root.phoneNumber)
        mobile_number.updateText(root.mobileNumber)
        address.updateText(root.officeAddress)
        address.updateText(root.officeAddress)
        //TODO update table
    }

}
