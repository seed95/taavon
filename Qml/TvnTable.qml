import QtQuick 2.0

Rectangle
{

    /***** Set this variables in qml *****/
    property string ceoName: ""
    property string chairmanName: ""
    property string viceName: ""
    property string secretaryName: ""
    property bool readOnlyTable: false

    border.color: "#e8e9e3"
    border.width: 1
    color: "transparent"
    radius: 5
    width: 300
    height: 175

    TvnTableItem
    {
        id: title
        anchors.top: parent.top
        anchors.right: parent.right
        positionText: "سمت"
        nameText: "نام و نام خانوادگی"
        colorText: "#c5c74d"
        readOnlyItem: true
    }

    TvnTableItem
    {
        id: ceo
        anchors.top: title.bottom
        anchors.right: parent.right
        positionText: "مدیر عامل"
        nameText: ceoName
        readOnlyItem: readOnlyTable
        selectable: true
    }

    TvnTableItem
    {
        id: chairman
        anchors.top: ceo.bottom
        anchors.right: parent.right
        positionText: "رئیس"
        nameText: chairmanName
        readOnlyItem: readOnlyTable
        selectable: true
    }

    TvnTableItem
    {
        id: vice
        anchors.top: chairman.bottom
        anchors.right: parent.right
        positionText: "نائب رئیس"
        nameText: viceName
        readOnlyItem: readOnlyTable
        selectable: true
    }

    TvnTableItem
    {
        id: secretary
        anchors.top: vice.bottom
        anchors.right: parent.right
        positionText: "منشی"
        nameText: secretaryName
        readOnlyItem: readOnlyTable
        hasBottomLine: false
        selectable: true
    }

}
