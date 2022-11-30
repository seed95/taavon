import QtQuick 2.0

Rectangle
{
    id: container

    /***** Set this variables in qml *****/
    // Show this variable in element
    property string colorBackground: ""
    property int index: 0
    property string fileCode: ""
    property string keepingPlace: ""
    property string status: ""
    property string ledgerBinder: ""
    property string numberOfCover: ""
    property string fileName: ""
    property string registrationNumber: ""
    property string dateOfLastMeeting: ""
    property string nationalId: ""
    property string ceoName: ""
    property string mobileNumber: ""

    // Save this variable in element for used in detail
    property string dateOfRegistration: ""
    property string numberOfPrimaryMembers: ""
    property string numberOfCurrentMembers: ""
    property string valuePerShare: ""
    property string startingCapital: ""
    property string currentCapital: ""
    property string chairmanName: ""
    property string viceName: ""
    property string secretaryName: ""
    property string phoneNumber: ""
    property string address: ""
    property bool extraordinaryMeetingHasImage: false
    property bool generalMeetingHasImage: false
    property bool licenceHasImage: false
    property bool registrationAdHasImage: false

    signal clickItem()
    signal editItem()

    height: 45
    width: 1250
    color: colorBackground

    TvnLabel
    {
        id: label_file_code
        width: 70
        anchors.right: parent.right
        anchors.top: parent.top
        labelText: fileCode
        labelFontSize: 24
    }

    TvnLabel
    {
        id: label_keeping_place
        width: 100
        anchors.right: label_file_code.left
        anchors.top: parent.top
        labelText: keepingPlace
        labelFontSize: 18
    }

    TvnLabel
    {
        id: label_status
        width: 95
        anchors.right: label_keeping_place.left
        anchors.top: parent.top
        labelText: status
        labelFontSize: 17
    }

    TvnLabel
    {
        id: ledger_binder
        width: 65
        anchors.right: label_status.left
        anchors.top: parent.top
        labelText: ledgerBinder
        labelFontSize: 17
    }

    TvnLabel
    {
        id: number_of_cover
        width: 38
        anchors.right: ledger_binder.left
        anchors.top: parent.top
        labelText: numberOfCover
        labelFontSize: 24
    }

    TvnLabel
    {
        id: file_name
        width: 293
        anchors.right: number_of_cover.left
        anchors.top: parent.top
        labelText: fileName
        labelFontSize: 16
    }

    TvnLabel
    {
        id: registration_number
        width: 75
        anchors.right: file_name.left
        anchors.top: parent.top
        labelText: registrationNumber
        labelFontSize: 24
    }

    TvnLabel
    {
        id: date_of_last_meeting
        width: 110
        anchors.right: registration_number.left
        anchors.top: parent.top
        labelText: dateOfLastMeeting
        labelFontSize: 19
    }

    TvnLabel
    {
        id: national_id
        width: 115
        anchors.right: date_of_last_meeting .left
        anchors.top: parent.top
        labelText: nationalId
        labelFontSize: 20
    }

    TvnLabel
    {
        id: ceo_name
        width: 145
        anchors.right: national_id.left
        anchors.top: parent.top
        labelText: ceoName
        labelFontSize: 16
    }

    TvnLabel
    {
        id: mobile_number
        width: 106
        anchors.right: ceo_name.left
        anchors.top: parent.top
        labelText: mobileNumber
        labelFontSize: 14
    }

    TvnLabel
    {
        id: edit
        width: 38
        anchors.right: mobile_number.left
        anchors.top: parent.top
        labelText: "\uf044"
        labelFontName: fontAwesomeSolid.name
        labelFontWeight: Font.Medium
        labelFontSize: 15
        labelColor: "#0e0b0b"

        MouseArea
        {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: editItem()
        }
    }

    MouseArea
    {
        anchors.right: parent.right
        anchors.left: edit.right
        height: parent.height
        anchors.top: parent.top
        onClicked: list_file.forceActiveFocus()
        onDoubleClicked: clickItem()
    }

}
