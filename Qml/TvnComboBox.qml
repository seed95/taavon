import QtQuick 2.0
import QtQuick.Controls 2.12

Item
{
    id: container

    property bool comboIsActive: false
    property string titleText: ""
    property int comboWidth: 0
    property var textItems: []
    property bool singleChoice: false
    property var selectedItems: [] // only set in outter qml object to select items

    property color color_background_normal: "#3b4351"
    property color color_background_hovered: "#576075"

    property color color_text_normal: "#e8e9e3"
    property color color_text_hovered: "#fafbf9"

    property color color_border_normal: color_text_normal
    property color color_border_hovered: color_text_hovered

    property bool isHovered: false
    property int highlighedItemIndex: 0
    property string headerText: ""

    signal clickItem(string text)
    signal changeSelectedItems()

    height: 35

    onTextItemsChanged: addToList()

    onSelectedItemsChanged:
    {
        deselectAllItem()
        selectSelectedItems()
        headerText = getSelectedItemText()
    }

    onFocusChanged:
    {
        if (!focus)
        {
            changeSelectedItems()
        }
    }

    Text
    {
        id: title
        text: titleText + ":"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        color: "#c5c74d"
        font.pixelSize: 16
        font.family: iranSansWebBold.name
        font.weight: Font.Bold
    }

    Item
    {
        id: combo
        width: comboWidth
        anchors.right: title.left
        anchors.rightMargin: 5
        anchors.top: parent.top

        Rectangle
        {
            id: combo_header
            width: parent.width
            height: 35
            anchors.right: parent.right
            anchors.top: parent.top
            border.width: 1
            border.color: isHovered? color_border_hovered : color_border_normal
            radius: 5
            color: isHovered? color_background_hovered : color_background_normal

            Text
            {
                id: caret
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                text: "\uf0d7"
                font.family: fontAwesomeSolid.name
                font.weight: Font.Medium
                font.pixelSize: 16
                color: isHovered? "#97989b" : "#7f8185"
            }

            Text
            {
                id: header
                anchors.right: caret.left
                anchors.rightMargin: 5
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                text: headerText
                font.family: iranSansWeb.name
                font.pixelSize: 17
                color: isHovered? color_text_normal : color_text_normal
                elide: Text.ElideRight
            }

            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: comboIsActive? Qt.PointingHandCursor : Qt.ArrowCursor
                enabled: comboIsActive

                onEntered: isHovered = true
                onExited: isHovered = false

                onClicked:
                {
                    if (container.focus)
                    {
                        root.updateFocus()
                    }
                    else
                    {
                        container.forceActiveFocus()
                    }
                }

            }

        }

        ListView
        {
            id: lv_combo
            height: 1000
            width: parent.width
            anchors.left: parent.left
            anchors.top: combo_header.bottom
            model: ListModel{id: lm_combo}
            clip: true
            interactive: false
            visible: container.focus
            delegate: TvnComboBoxItem
            {
                displayText: itemText
                index: itemIndex
                isHovered: index === container.highlighedItemIndex
                isChecked: isSelected

                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: container.highlighedItemIndex = index
                    onClicked: handleClickItem(index)
                }
            }
        }

    }

    function handleClickItem(index)
    {
        var item = lm_combo.get(index)
        if (container.singleChoice)
        {
            if (item.isSelected)
            {
                return
            }
            deselectAllItem()
            item.isSelected = true
            clickItem(item.itemText)
        }
        else
        {
            item.isSelected = !item.isSelected
        }
        headerText = getSelectedItemText()
//        changeSelectedItems()
    }

    function getSelectedItemText()
    {
        var txt = ""
        for (var i=0; i<lm_combo.count; i++)
        {
            if (lm_combo.get(i).isSelected)
            {
                if (txt==="")
                {
                    txt = lm_combo.get(i).itemText
                }
                else
                {
                    txt += " - " + lm_combo.get(i).itemText
                }
            }
        }
        return txt
    }

    function deselectAllItem()
    {
        for (var i=0; i<lm_combo.count; i++)
        {
            lm_combo.get(i).isSelected = false
        }
    }

    function selectSelectedItems()
    {
        for (var i=0; i<selectedItems.length; i++)
        {
            lm_combo.get(selectedItems[i]).isSelected = true
        }
    }

    function addToList()
    {
        lm_combo.clear()
        for (var i=0; i<textItems.length; i++)
        {
            lm_combo.append({"itemText": textItems[i],
                             "itemIndex":i,
                             "isSelected": false})
        }
    }

    function getSelectedItems()
    {
        var selected = []
        for (var i=0; i<lm_combo.count; i++)
        {
            if (lm_combo.get(i).isSelected)
            {
                selected.push(lm_combo.get(i).itemText)
            }
        }
        return selected
    }
}

