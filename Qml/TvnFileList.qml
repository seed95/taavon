import QtQuick 2.0
import QtQuick.Controls 2.0

Item
{
    id: container

    /***** Set this variables in cpp *****/
    property string fileCode: "127"
    property string keepingPlace: "بایگانی/دایی"
    property string status: "غیر فعال"
    property string ledgerBinder: "زونکن"
    property string numberOfCover: "3"
    property string fileName: "پسته کاری گلچهرگان آران"
    property string registrationNumber: "1059"
    property string dateOfLastMeeting: "۱۳۹۵/۸/۱۶"
    property string nationalId: "10260098471"
    property string ceoName: "محسن اکبری"
    property string mobileNumber: "09123456789"
    property string dateOfRegistration: "۱۳۹۵/۸/۱۶"
    property string numberOfPrimaryMembers: "7"
    property string numberOfCurrentMembers: "7"
    property string valuePerShare: "1000000"
    property string startingCapital: "100000000"
    property string currentCapital: "90000000"
    property string chairmanName: "محسن فرقانی نوش آبادی"
    property string viceName: "محسن فرقانی نوش آبادی"
    property string secretaryName: "محسن فرقانی نوش آبادی"
    property string phoneNumber: "03154754744"
    property string address: "آران و بیدگل شهرک صنعتی هلال کارخانه مشهد نگین توس"


    property string color_background_1: "#414858"
    property string color_background_2: "#576075"

    Component.onCompleted:
    {
        for(var i=0; i<10; i++)
        {
            addToList()
        }
    }

//    //Cpp Signals
//    signal readEmail(int idEmail)

//    //Qml Signals
//    signal clickEmail(int idEmail, int idItem)


    ListView
    {
        id: lv_file

        width: parent.width
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        model: ListModel{id: lm_file}
        clip: true

        delegate: TvnFileElement
        {
            anchors.right: parent.right
            colorBackground: elementColorBackground
            fileCode: elementFileCode
            keepingPlace: elementKeepingPlace
            status: elementStatus
            ledgerBinder: elementLedgerBinder
            numberOfCover: elementNumberOfCover
            fileName: elementFileName
            registrationNumber: elementRegistrationNumber
            dateOfLastMeeting: elementDateOfLastMeeting
            nationalId: elementNationalId
            ceoName: elementCeoName
            mobileNumber: elementMobileNumber
            dateOfRegistration: elementDateOfRegistration
            numberOfPrimaryMembers: elementNumberOfPrimaryMembers
            numberOfCurrentMembers: elementNumberOfCurrentMembers
            valuePerShare: elementValuePerShare
            startingCapital: elementStartingCapital
            currentCapital: elementCurrentCapital
            chairmanName: elementChairmanName
            viceName: elementViceName
            secretaryName: elementSecretaryName
            phoneNumber: elementPhoneNumber
            address: elementAddress

            onClickItem:
            {
                root.fileCode = fileCode
                root.fileStatus = status
                root.keepingPlace = keepingPlace
                root.ledgerBinder = ledgerBinder
                root.numberOfCover = numberOfCover
                root.fileName = fileName
                root.registrationNumber = registrationNumber
                root.dateOfRegistration = dateOfRegistration
                root.nationalId = nationalId
                root.dateOfLastMeeting = dateOfLastMeeting
                root.numberOfPrimaryMembers = numberOfPrimaryMembers
                root.numberOfCurrentMembers = numberOfCurrentMembers
                root.valuePerShare = valuePerShare
                root.startingCapital = startingCapital
                root.currentCapital = currentCapital
                root.phoneNumber = phoneNumber
                root.mobileNumber = mobileNumber
                root.officeAddress = address
                root.ceoName = ceoName
                root.chairmanName = chairmanName
                root.viceName = viceName
                root.secretaryName = secretaryName
                root.viewFile()
            }

            onEditItem:
            {
                root.editFile()

            }
        }

        ScrollBar.vertical: scrollbar
    }

    ScrollBar
    {
        id: scrollbar
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        policy: ScrollBar.AsNeeded

        background: Rectangle
        {
            width: 6
            anchors.left: parent.left
            anchors.top: parent.top
            color: "#b4b4b4"
        }

        contentItem: Rectangle
        {
            anchors.left: parent.left
            radius: 3
            implicitWidth: 6
            implicitHeight: 400
            color: "#646464"
        }
    }


    function addToList()
    {
        var color_background = color_background_1
        if (lm_file.count%2 === 0)
        {
            color_background = color_background_2
        }

        lm_file.append({"elementColorBackground": color_background,
                        "elementFileCode" : container.fileCode,
                        "elementKeepingPlace" : container.keepingPlace,
                        "elementStatus" : container.status,
                        "elementLedgerBinder" : container.ledgerBinder,
                        "elementNumberOfCover" : container.numberOfCover,
                        "elementFileName" : container.fileName,
                        "elementRegistrationNumber" : container.registrationNumber,
                        "elementDateOfLastMeeting" : container.dateOfLastMeeting,
                        "elementNationalId" : container.nationalId,
                        "elementCeoName" : container.ceoName,
                        "elementMobileNumber" : container.mobileNumber,
                        "elementDateOfRegistration" : container.dateOfRegistration,
                        "elementNumberOfPrimaryMembers" : container.numberOfPrimaryMembers,
                        "elementNumberOfCurrentMembers" : container.numberOfCurrentMembers,
                        "elementValuePerShare" : container.valuePerShare,
                        "elementStartingCapital" : container.startingCapital,
                        "elementCurrentCapital" : container.currentCapital,
                        "elementChairmanName" : container.chairmanName,
                        "elementViceName" : container.chairmanName,
                        "elementSecretaryName" : container.secretaryName,
                        "elementPhoneNumber" : container.phoneNumber,
                        "elementAddress" : container.address})
    }


}
