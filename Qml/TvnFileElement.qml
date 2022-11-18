import QtQuick 2.0

Rectangle
{
    id: container


    /***** Set this variables in qml *****/
    // Show this variable in element
    property string colorBackground: ""
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
    property string numberOfMembers: ""
    property string lastRegisteredCapital: ""
    property string yearOfDissolution: ""
    property string chairmanName: ""
    property string secretaryName: ""
    property string phoneNumber: ""
    property string address: ""

    signal clickItem()

    height: 45
    width: 1247
    color: colorBackground

    TvnLabel
    {
        id: label_file_code
        width: 72
        anchors.right: parent.right
        anchors.top: parent.top
        labelText: "127"
        labelFontSize: 22
    }

    TvnLabel
    {
        id: label_keeping_place
        width: 113
        anchors.right: label_file_code.left
        anchors.top: parent.top
        labelText: "بایگانی دایی"
        labelFontSize: 16
    }

//    MouseArea
//    {
//        anchors.fill: parent
//        hoverEnabled: true

//        onEntered:
//        {
//            container.isHovered = true
//        }

//        onExited:
//        {
//            container.isHovered = false
//        }

//        onClicked:
//        {
//            clickItem()
//        }

//    }

}
