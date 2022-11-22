import QtQuick 2.0
import QtQuick.Controls 2.5

Item {

    property string titleText: ""
    property string contentText: ""
    property string parenthesesText: ""
    property int contentFontSize: 19
    property bool contentReadOnly: true
    property bool haveBackground: false
    property bool haveBorder: !contentReadOnly
    property int inputWidth: 0
    property bool alignCenter: !contentReadOnly

    property bool isActive: false

    height: 45

    Text
    {
        id: title
        text: parentheses.visible? titleText : titleText + ":"
        color: "#c5c74d"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        font.family: iranSansWebBold.name
        font.weight: Font.Bold
        font.pixelSize: 16
    }

    Text
    {
        id: parentheses
        text: "(" + parenthesesText + "):"
        color: "#c5c74d"
        anchors.right: title.left
        anchors.rightMargin: 2
        anchors.verticalCenter: parent.verticalCenter
        font.family: iranSansWebBold.name
        font.weight: Font.Bold
        font.pixelSize: 11
        visible: parenthesesText!==""
    }

    Rectangle
    {
        width: inputWidth
        height: 35
        anchors.right: parentheses.visible? parentheses.left : title.left
        anchors.rightMargin: haveBorder? 8:-2
        anchors.verticalCenter: parent.verticalCenter
        radius: 5
        border.width: 1
        border.color:
        {
            if (haveBorder)
            {
                if (content.focus)
                {
                    "#fafbf9"
                }
                else
                {
                    "#e8e9e3"
                }
            }
            else
            {
                "transparent"
            }
        }
        color:
        {
            if (haveBackground)
            {
                if (content.focus)
                {
                    "#576075"
                }
                else
                {
                    "#3b4351"
                }
            }
            else
            {
                "transparent"
            }
        }

        TextField
        {
            id: content

            width: parent.width
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            text: contentText
            horizontalAlignment:
            {
                if (alignCenter)
                {
                    TextInput.AlignHCenter
                }
                else
                {
                    if (contentText.length>50) // 50 -> fix large contentText
                    {
                        TextInput.AlignLeft
                    }
                    else
                    {
                        TextInput.AlignRight
                    }
                }
            }
            font.family: iranSansWeb.name
            font.pixelSize: contentFontSize
            selectByMouse: true
            readOnly: contentReadOnly
            clip: true
            background: Rectangle{color: "transparent"}
            color: "#e8e9e2"
            onAccepted: focus = false
            Keys.onEscapePressed: focus = false

        }
    }

}
