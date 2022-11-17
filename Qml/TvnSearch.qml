import QtQuick 2.0

Rectangle {

    color: "#00003b"
    width: 1247
    height: 45

    TvnSearchBtn
    {
        id: file_code
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        titleText: "کد پرونده"
        inputWidth: 68
    }

}
