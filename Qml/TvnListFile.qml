import QtQuick 2.0
import QtQuick.Controls 2.0

Item
{
    id: listFile

    property string color_background_1: "#414858"
    property string color_background_2: "#576075"
    property bool isActive: windowIsActive()


//    Keys.onEscapePressed:
//    {
//        if (isActive)
//        {
//            root.pageMode = constant.tvn_LIST_FILE
//        }
//    }
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
        interactive: isActive

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
                handleClickItem(index)
                root.pageMode = constant.tvn_VIEW_FILE
            }

            onEditItem:
            {
                handleClickItem(index)
                root.pageMode = constant.tvn_EDIT_FILE
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
                        "elementFileCode" : root.fileCode,
                        "elementKeepingPlace" : root.keepingPlace,
                        "elementStatus" : root.fileStatus,
                        "elementLedgerBinder" : root.ledgerBinder,
                        "elementNumberOfCover" : root.numberOfCover,
                        "elementFileName" : root.fileName,
                        "elementRegistrationNumber" : root.registrationNumber,
                        "elementDateOfLastMeeting" : root.dateOfLastMeeting,
                        "elementNationalId" : root.nationalId,
                        "elementCeoName" : root.ceoName,
                        "elementMobileNumber" : root.mobileNumber,
                        "elementDateOfRegistration" : root.dateOfRegistration,
                        "elementNumberOfPrimaryMembers" : root.numberOfPrimaryMembers,
                        "elementNumberOfCurrentMembers" : root.numberOfCurrentMembers,
                        "elementValuePerShare" : root.valuePerShare,
                        "elementStartingCapital" : root.startingCapital,
                        "elementCurrentCapital" : root.currentCapital,
                        "elementChairmanName" : root.chairmanName,
                        "elementViceName" : root.chairmanName,
                        "elementSecretaryName" : root.secretaryName,
                        "elementPhoneNumber" : root.phoneNumber,
                        "elementAddress" : root.officeAddress,
                        "elementExtraordinaryMeetingImage" : root.extraordinaryMeetingHasImage,
                        "elementGeneralMeetingImage" : root.generalMeetingHasImage,
                        "elementLicenceImage" : root.licenceHasImage,
                        "elementRegistrationAdImage" : root.registrationAdHasImage})
    }

    /*** Call this functions from qml ***/
    function windowIsActive()
    {
        if (root.pageMode===constant.tvn_LIST_FILE && root.errorMessage==="")
        {
            return true
        }
        return false
    }

    function handleClickItem(index)
    {
        var item = lm_file.get(index)
        root.selectedFileIndex = index
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

    // update selected file in EditFile from root variables
    // when edit selected file and save successfully in csv.
    function updateFile()
    {
        var item = lm_file.get(root.selectedFileIndex)
        item.elementFileCode = root.fileCode
        item.elementStatus = root.fileStatus
        item.elementKeepingPlace = root.keepingPlace
        item.elementLedgerBinder = root.ledgerBinder
        item.elementNumberOfCover = root.numberOfCover
        item.elementFileName = root.fileName
        item.elementRegistrationNumber = root.registrationNumber
        item.elementDateOfRegistration = root.dateOfRegistration
        item.elementNationalId = root.nationalId
        item.elementDateOfLastMeeting = root.dateOfLastMeeting
        item.elementNumberOfPrimaryMembers = root.numberOfPrimaryMembers
        item.elementNumberOfCurrentMembers = root.numberOfCurrentMembers
        item.elementValuePerShare = root.valuePerShare
        item.elementStartingCapital = root.startingCapital
        item.elementCurrentCapital = root.currentCapital
        item.elementPhoneNumber = root.phoneNumber
        item.elementMobileNumber = root.mobileNumber
        item.elementAddress = root.officeAddress
        item.elementCeoName = root.ceoName
        item.elementChairmanName = root.chairmanName
        item.elementViceName = root.viceName
        item.elementSecretaryName = root.secretaryName
        item.elementExtraordinaryMeetingImage = root.extraordinaryMeetingHasImage
        item.elementGeneralMeetingImage = root.generalMeetingHasImage
        item.elementLicenceImage = root.licenceHasImage
        item.elementRegistrationAdImage = root.registrationAdHasImage
    }

    function forceFocus()
    {
        listFile.forceActiveFocus()
    }

    // Based on the selected image type,
    // it returns whether there is a image in the share folder or not.
    // call this function when delete button click in EditFile, to check
    // selected file has image for selected type.
    function getHasImage()
    {
        var item = lm_file.get(root.selectedFileIndex)
        if (root.imageType===constant.tvn_IMAGE_EXTRAORDINARY_MEETING)
        {
            return item.elementExtraordinaryMeetingImage
        }
        else if (root.imageType===constant.tvn_IMAGE_GENERAL_MEETING)
        {
            return item.elementGeneralMeetingImage
        }
        else if (root.imageType===constant.tvn_IMAGE_LICENCE)
        {
            return item.elementLicenceImage
        }
        else if (root.imageType===constant.tvn_IMAGE_REGISTRATION_AD)
        {
            return item.elementRegistrationAdImage
        }
    }
}
