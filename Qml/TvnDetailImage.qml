import QtQuick 2.0

Item {

    property bool extraordinaryHasImage: false
    property bool generalHasImage: false
    property bool licenceHasImage: false
    property bool registrationHasImage: false

    signal downloadImage(int type)
    signal deleteImage(int type)
    signal uploadImage(int type)

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
        onClickIcon: handleClickImage(constant.tvn_IMAGE_REGISTRATION_AD, registrationHasImage)
    }


    function handleClickImage(type, hasImage)
    {
        if (root.pageMode===constant.tvn_VIEW_FILE)
        {
            downloadImage(type)
        }
        else if (root.pageMode===constant.tvn_EDIT_FILE)
        {
            if (hasImage)
            {
                deleteImage(type)
            }
            else
            {
                uploadImage(type)
            }
        }
    }

}
