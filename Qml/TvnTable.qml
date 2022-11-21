import QtQuick 2.0

Rectangle {

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
        selectable: false
    }

    TvnTableItem
    {
        id: ceo
        anchors.top: title.bottom
        anchors.right: parent.right
        positionText: "مدیر عامل"
        nameText: "سجاد داداشی آرانی"
    }

    TvnTableItem
    {
        id: chairman
        anchors.top: ceo.bottom
        anchors.right: parent.right
        positionText: "رئیس"
        nameText: "سجاد داداشی آرانی و بیدگلی"
    }

    TvnTableItem
    {
        id: vice
        anchors.top: chairman.bottom
        anchors.right: parent.right
        positionText: "نائب رئیس"
        nameText: "سجاد داداشی آرانی و بیدگلی سجاد داداشی آرانی و بیدگلی"
    }

    TvnTableItem
    {
        id: secretary
        anchors.top: vice.bottom
        anchors.right: parent.right
        positionText: "منشی"
        nameText: "سجاد داداشی آرانی و بیدگلی"
        hasBottomLine: false
    }

}
