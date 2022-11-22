import QtQuick 2.0

Rectangle
{

    width: 945
    height: 415
    color: "#2f343f"
    radius: 5
    border.width: 2
    border.color: "#e8e9e3"


    TvnDetail
    {
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 40
        fileCodeReadOnly: true
        readOnly: true
        containBackground: false
    }

}
