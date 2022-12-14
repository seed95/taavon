import QtQuick 2.0

Item
{
    property bool searchIsActive: false


    width: 1250
    height: 45

    TvnSearchBtn
    {
        id: file_code
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        isActive: searchIsActive
        titleText: "کد پرونده"
        inputWidth: 60
        labelValidator: IntValidator {bottom: 1; top: 1000; locale: "fa"}
        onTextChange: handleFileCode(text)
    }

    TvnSearchBtn
    {
        id: file_name
        anchors.right: file_code.left
        anchors.rightMargin: 30
        anchors.verticalCenter: parent.verticalCenter
        isActive: searchIsActive
        titleText: "اسم پرونده"
        inputWidth: 280
        onTextChange: handleFileName(text)
    }

    TvnSearchBtn
    {
        id: registration_number
        anchors.right: file_name.left
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        isActive: searchIsActive
        titleText: "شماره ثبت"
        inputWidth: 70
        labelValidator: IntValidator {bottom: 1; top: 1000; locale: "fa"}
        onTextChange: handleRegistrationNumber(text)
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
        textItems: constant.tvn_COMBO_STATUS_ITEMS
        onChangeSelectedItems: handleCombo()
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
        textItems: constant.tvn_COMBO_KEEPING_PLACE_ITEMS
        onChangeSelectedItems: handleCombo()
    }


    function handleFileCode(text)
    {
        file_name.clearInput()
        registration_number.clearInput()
        list.searchFile(constant.tvn_SEARCH_FILE_CODE, text, status.getSelectedItems(), keeping_palce.getSelectedItems())
    }

    function handleFileName(text)
    {
        file_code.clearInput()
        registration_number.clearInput()
        list.searchFile(constant.tvn_SEARCH_FILE_NAME, text, status.getSelectedItems(), keeping_palce.getSelectedItems())
    }

    function handleRegistrationNumber(text)
    {
        file_code.clearInput()
        file_name.clearInput()
        list.searchFile(constant.tvn_SEARCH_REGISTRATION_NUMBER, text, status.getSelectedItems(), keeping_palce.getSelectedItems())
    }

    function handleCombo()
    {
        var name = file_name.getInput()
        if (name!=="")
        {
            handleFileName(name)
            return
        }

        var registration = registration_number.getInput()
        if (registration!=="")
        {
            handleRegistrationNumber(registration)
            return
        }

        var code = file_code.getInput()
        handleFileCode(code)
    }

}
