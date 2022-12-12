import QtQuick 2.0

Item
{

    property bool imageIsActive: false
    property bool extraordinaryHasImage: false
    property bool generalHasImage: false
    property bool licenceHasImage: false
    property bool registrationHasImage: false

    signal downloadImage()
//    signal deleteImage()
    signal uploadImage()
    signal chooseImage()

    height: 45

    Text
    {
        id: title
        text: "تصاویر:"
        color: "#c5c74d"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        font.family: iranSansWebBold.name
        font.weight: Font.Bold
        font.pixelSize: 16
    }

    TvnImageBtn
    {
        id: last_extraordinary_general_meeting
        width: 250
        anchors.right: title.left
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        labelText: "آخرین مجمع فوق العاده"
        hasImage: extraordinaryHasImage
        imageButtonisActive: imageIsActive
        onClickIcon: handleClickImage(constant.tvn_IMAGE_EXTRAORDINARY_MEETING, extraordinaryHasImage)
    }

    TvnImageBtn
    {
        id: last_general_meeting
        width: 235
        anchors.right: last_extraordinary_general_meeting.left
        anchors.rightMargin: 22
        anchors.verticalCenter: parent.verticalCenter
        labelText: "آخرین مجمع سالانه"
        hasImage: generalHasImage
        imageButtonisActive: imageIsActive
        onClickIcon: handleClickImage(constant.tvn_IMAGE_GENERAL_MEETING, generalHasImage)
    }

    TvnImageBtn
    {
        id: license
        width: 125
        anchors.right: last_general_meeting.left
        anchors.rightMargin: 22
        anchors.verticalCenter: parent.verticalCenter
        labelText: "مجوز"
        hasImage: licenceHasImage
        imageButtonisActive: imageIsActive
        onClickIcon: handleClickImage(constant.tvn_IMAGE_LICENCE, licenceHasImage)
    }

    TvnImageBtn
    {
        id: registration_ad
        width: 160
        anchors.right: license.left
        anchors.rightMargin: 22
        anchors.verticalCenter: parent.verticalCenter
        labelText: "آگهی ثبت"
        hasImage: registrationHasImage
        imageButtonisActive: imageIsActive
        onClickIcon: handleClickImage(constant.tvn_IMAGE_REGISTRATION_AD, registrationHasImage)
    }


    function handleClickImage(type, hasImage)
    {
        root.imageType = type
        if (root.pageMode===constant.tvn_VIEW_FILE)
        {
            root.processType = constant.tvn_PROCESS_IMAGE_DOWNLOAD
            downloadImage()
        }
        else if (root.pageMode===constant.tvn_EDIT_FILE)
        {
            if (hasImage)
            {
                handleDeleteImage()
//                root.processType = constant.tvn_PROCESS_IMAGE_REMOVE
//                deleteImage()
            }
            else
            {
//                root.processType = constant.tvn_PROCESS_IMAGE_UPLOAD
//                uploadImage()
                chooseImage()
            }
        }
    }

    function handleDeleteImage()
    {
        root.hasChanged = true
        var hasImage = list.getHasImage()
        if (root.imageType===constant.tvn_IMAGE_EXTRAORDINARY_MEETING)
        {
            root.extraordinaryDeleted = hasImage
            root.extraordinaryMeetingHasImage = false
        }
        else if (root.imageType===constant.tvn_IMAGE_GENERAL_MEETING)
        {
            root.generalDeleted = hasImage
            root.generalMeetingHasImage = false
        }
        else if (root.imageType===constant.tvn_IMAGE_LICENCE)
        {
            root.licenceDeleted = hasImage
            root.licenceHasImage = false
        }
        else if (root.imageType===constant.tvn_IMAGE_REGISTRATION_AD)
        {
            root.registrationDeleted = hasImage
            root.registrationAdHasImage = false
        }
    }

}
