import QtQuick 2.0
import QtQuick.Controls 2.5

Item
{

    property var labelValidator: RegExpValidator { regExp: /^[^,]*$/ }
    property bool labelIsActive: false
    property string titleText: ""
    property string contentText: ""
    property string parenthesesText: ""
    property int contentFontSize: 19
    property bool contentReadOnly: true
    property bool contentEnable: true // used for file code to show disable
    property bool haveBackground: false
    property bool haveBorder: !contentReadOnly
    property int inputWidth: 0
    property bool alignCenter: !contentReadOnly
    property bool isCurrency: false

    signal changeItem(string text)

    height: 45

//    Component.onCompleted: console.log(Number("12090450").toLocaleString(Qt.locale("fa-IR"),'f',0))

    Text
    {
        id: title
        text: parentheses.visible? titleText : titleText
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
        text: "(" + parenthesesText + ")"
        color: "#c5c74d"
        anchors.right: title.left
        anchors.rightMargin: 2
        anchors.verticalCenter: parent.verticalCenter
        font.family: iranSansWebBold.name
        font.weight: Font.Bold
        font.pixelSize: 11
        visible: parenthesesText!==""
    }

    Text
    {
        id: colon
        text: ":"
        color: "#c5c74d"
        anchors.right: parentheses.visible? parentheses.left : title.left
        anchors.rightMargin: 2
        anchors.verticalCenter: parent.verticalCenter
        font.family: iranSansWebBold.name
        font.weight: Font.Bold
        font.pixelSize: 16
    }

    Rectangle
    {
        width: inputWidth
        height: 35
        anchors.right: colon.left
        anchors.rightMargin: haveBorder? 8:-2
        anchors.verticalCenter: parent.verticalCenter
        radius: 5
        border.width: 1
        border.color:
        {
            if (haveBorder)
            {
                if (!contentEnable)
                {
                    "#80807f"
                }
                else if (content.focus)
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
                if (!contentEnable)
                {
                    "#3b4351"
                }
                else if (content.focus)
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
            text:
            {
                if (isCurrency)
                {
                    Number(contentText).toLocaleString(Qt.locale("en-US"), 'f', 0)
                }
                else
                {
                    contentText
                }
            }
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
            validator: labelValidator
            readOnly: contentReadOnly
            clip: true
            background: Rectangle{color: "transparent"}
            color:
            {
                if (!contentEnable)
                {
                    "#b3b3b2"
                }
                else if (content.focus)
                {
                    "#fafbf9"
                }
                else
                {
                    "#e8e9e3"
                }

            }
            onAccepted: focus = false
            Keys.onEnterPressed: focus = false
            Keys.onEscapePressed:
            {
                text = contentText
                focus = false
            }
            enabled: labelIsActive
            onFocusChanged:
            {
                if (!focus)
                {
                    if (text==="")
                    {
                        text = contentText
                    }

                    // convert persian number to english
                    text = root.fa2en(text)

                    if (text!==contentText)
                    {
                        root.hasChanged = true
                        contentText = text
                    }

                    changeItem(text)
                    if (isCurrency)
                    {
                        // show currency with comma
                        text = Number(text).toLocaleString(Qt.locale("en-US"), 'f', 0)
                    }
                    root.updateFocus()
                }
                else
                {
                    text = contentText
                }
            }
        }
    }

    function updateText(text)
    {
        content.text = text
    }

}
