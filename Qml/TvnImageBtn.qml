import QtQuick 2.0

Item
{
    property string labelText: ""
    property bool hasImage: true
    property bool disabled: false
    property bool imageButtonisActive: false

    property string icon_text:
    {
        if (root.pageMode === constant.tvn_EDIT_FILE)
        {
            if (hasImage)
            {
                "\ue2ae"
            }
            else
            {
                "\uf319"
            }
        }
        else // VIEW MODE
        {
            "\uf0ed"
        }
    }

    signal clickIcon()

    height: 35

    TvnRoundBtn
    {
        id: rect_icon
        width: 30
        height: 35
        anchors.right: parent.right
        anchors.top: parent.top
        radiusButton: 5
        typeButton: 1
        fontName: fontAwesomeSolid.name
        fontWeight: Font.Medium
        fontSize: 14
        textButton: icon_text
        disabledButton: !hasImage
        clickable: !(root.pageMode === constant.tvn_VIEW_FILE && !hasImage) && imageButtonisActive
        onButtonClicked: clickIcon()
    }

    TvnRoundBtn
    {
        id: rect_label
        width: 30
        height: 35
        anchors.right: rect_icon.left
        anchors.rightMargin: -1
        anchors.left: parent.left
        anchors.top: parent.top
        radiusButton: 5
        typeButton: 2
        textButton: labelText
        disabledButton: !hasImage
        clickable: false
    }

}
