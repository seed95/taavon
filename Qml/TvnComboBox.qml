import QtQuick 2.0
import QtQuick.Controls 2.12



Rectangle
{
    id: container

    property string titleText: ""
    property int comboWidth: 0

    property color color_background_normal: "#3b4351"
    property color color_background_hovered: "#576075"

    property color color_text_normal: "#e8e9e3"
    property color color_text_hovered: "#fafbf9"

    property color color_border_normal: color_text_normal
    property color color_border_hovered: color_text_hovered

    property bool isHovered: false

    height: 34
    width: title.width + combo.width + 5
    color: "transparent"

    Component.onCompleted: {addToList()}

    Text
    {
        id: title
        text: titleText + ":"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        font.family: iranSansWebBold.name
        font.weight: Font.Bold
        font.pixelSize: 14
        color: "#c5c74d"
    }

    Rectangle
    {
        id: combo
        width: comboWidth
        height: 1000
        anchors.right: title.left
        anchors.rightMargin: 5
        anchors.top: parent.top
        color: "transparent"

        Rectangle
        {
            id: combo_header
            width: parent.width
            height: 34
            anchors.right: parent.right
            anchors.top: parent.top

            border.width: 1
            border.color: isHovered? color_border_hovered:color_border_normal
            radius: 5
            color: isHovered? color_background_hovered:color_background_normal

            Rectangle
            {
                id: rect_caret
                width: 20
                height: parent.height
                anchors.right: parent.right
                color: "transparent"

                Text
                {
                    id: caret
                    anchors.centerIn: parent
                    text: "+"
                    font.family: fontAwesomeSolid.name
                    font.pixelSize: 12
                    color: isHovered? color_text_normal:color_text_normal
                }
            }

            Rectangle
            {
                height: parent.height
                anchors.right: rect_caret.left
                anchors.left: parent.left
                anchors.leftMargin: 5
                color: "transparent"

                Text
                {
                    id: hedear_text
                    anchors.centerIn: parent
                    text: "در دست اقدام"
                    font.family: iranSansWeb.name
                    font.pixelSize: 14
                    color: isHovered? color_text_normal:color_text_normal
                    elide: Text.ElideLeft
                }

            }


            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onEntered: isHovered = true
                onExited: isHovered = false

                onClicked: lv_combo.visible = !lv_combo.visible
            }

        }

        ListView
        {
            id: lv_combo
            height: contentHeight
            width: parent.width
            anchors.left: parent.left
//            anchors.right: parent.right
            anchors.top: combo_header.bottom
            anchors.topMargin: -1
            visible: false
    //        anchors.bottom: parent.bottom
    //        implicitHeight: contentHeight
    //        model: control.popup.visible ? control.delegateModel : null
    //        currentIndex: control.highlightedIndex
            clip: true
            interactive: false

            model: ListModel{id: lm_combo}
            delegate: TvnComboBoxItem
            {
                width: lv_combo.width
                displayText: itemText
                index: itemIndex

                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {console.log(lv_combo.currentIndex);lv_combo.currentIndex = index}
                }
            }

            onCountChanged: {
               lv_combo.currentIndex = -1
            }


            highlight: Rectangle{width: lv_combo.width; height: 35;color: "#576075"}
            highlightFollowsCurrentItem: false

//            ScrollIndicator.vertical: ScrollIndicator { }
        }



    }



    function addToList() {
        lm_combo.append({"itemText": "در دست اقدام", "itemIndex":0})
        lm_combo.append({"itemText": "فعال", "itemIndex":1})
        lm_combo.append({"itemText": "غیر فعال", "itemIndex":2})
        lm_combo.append({"itemText": "منحل", "itemIndex":3})
    }

}

