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
    property bool extraordinaryMeetingHasImage: false
    property bool generalMeetingHasImage: false
    property bool licenceHasImage: false
    property bool registrationAdHasImage: false

    property string color_background_1: "#414858"
    property string color_background_2: "#576075"


    Keys.onEscapePressed: root.pageMode = constant.tvn_LIST_FILE
    //Cpp Signals

    //Qml Signals


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
            index: elementIndex
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
            extraordinaryMeetingHasImage: elementExtraordinaryMeetingImage
            generalMeetingHasImage: elementGeneralMeetingImage
            licenceHasImage: elementLicenceImage
            registrationAdHasImage: elementRegistrationAdImage

            onClickItem:
            {
                if (root.pageMode===constant.tvn_LIST_FILE)
                {
                    handleClickItem(index)
                    root.pageMode = constant.tvn_VIEW_FILE
                }

            }

            onEditItem:
            {
                if (root.pageMode===constant.tvn_LIST_FILE)
                {
                    handleClickItem(index)
                    root.pageMode = constant.tvn_EDIT_FILE
                }
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


    //Functions
    /*** Call this functions from cpp ***/
    function addToList()
    {
        var color_background = color_background_1
        if (lm_file.count%2 === 0)
        {
            color_background = color_background_2
        }

        lm_file.append({"elementColorBackground": color_background,
                        "elementIndex" : lm_file.count,
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
                        "elementAddress" : container.address,
                        "elementExtraordinaryMeetingImage" : container.extraordinaryMeetingHasImage,
                        "elementGeneralMeetingImage" : container.generalMeetingHasImage,
                        "elementLicenceImage" : container.licenceHasImage,
                        "elementRegistrationAdImage" : container.registrationAdHasImage})
    }

    /*** Call this functions from qml ***/
    function handleClickItem(index)
    {
        var item = lm_file.get(index)
        root.fileCode = item.elementFileCode
        root.fileStatus = item.elementStatus
        root.keepingPlace = item.elementKeepingPlace
        root.ledgerBinder = item.elementLedgerBinder
        root.numberOfCover = item.elementNumberOfCover
        root.fileName = item.elementFileName
        root.registrationNumber = item.elementRegistrationNumber
        root.dateOfRegistration = item.elementDateOfRegistration
        root.nationalId = item.elementNationalId
        root.dateOfLastMeeting = item.elementDateOfLastMeeting
        root.numberOfPrimaryMembers = item.elementNumberOfPrimaryMembers
        root.numberOfCurrentMembers = item.elementNumberOfCurrentMembers
        root.valuePerShare = item.elementValuePerShare
        root.startingCapital = item.elementStartingCapital
        root.currentCapital = item.elementCurrentCapital
        root.phoneNumber = item.elementPhoneNumber
        root.mobileNumber = item.elementMobileNumber
        root.officeAddress = item.elementAddress
        root.ceoName = item.elementCeoName
        root.chairmanName = item.elementChairmanName
        root.viceName = item.elementViceName
        root.secretaryName = item.elementSecretaryName
        root.extraordinaryMeetingHasImage = item.elementExtraordinaryMeetingImage
        root.generalMeetingHasImage = item.elementGeneralMeetingImage
        root.licenceHasImage = item.elementLicenceImage
        root.registrationAdHasImage = item.elementRegistrationAdImage
    }

}
