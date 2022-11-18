import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.4
import Qt.labs.settings 1.0

Window
{
    id: root

    //Error properties
    property string error_text:         ""
    property int    error_duration:     100

    signal loginUser(string username, string pass)
    signal replyButtonClicked()
    signal archiveButtonClicked()
    signal scanButtonClicked()
    signal flagButtonClicked(int id)

    visible: true
    width: 1300
    height: 700
    minimumHeight: height
    maximumHeight: height
    minimumWidth: width
    maximumWidth: width
    color: "#2f343f"

    //Fonts:
    FontLoader
    {
        id: fontAwesomeSolid
        source: "qrc:/Fonts/Fontawesome/fasolid.ttf"
    }
    FontLoader
    {
        id: fontAwesomeBrand
        source: "qrc:/Fonts/Fontawesome/fa-brands-400.ttf"
    }
    FontLoader
    {
        id: fontAwesomeRegular
        source: "qrc:/Fonts/Fontawesome/fa-regular-400.ttf"
    }

    FontLoader
    {
        id: iranSansWeb
        source: "qrc:/Fonts/IRANSansWeb/IRANSansWeb.ttf"
    }
    FontLoader
    {
        id: iranSansWebBold
        source: "qrc:/Fonts/IRANSansWeb/IRANSansWebBold.ttf"
    }
    FontLoader
    {
        id: iranSansWebLight
        source: "qrc:/Fonts/IRANSansWeb/IRANSansWebLight.ttf"
    }
    FontLoader
    {
        id: iranSansWebMedium
        source: "qrc:/Fonts/IRANSansWeb/IRANSansWebMedium.ttf"
    }
    FontLoader
    {
        id: iranSansWebUlrtaLight
        source: "qrc:/Fonts/IRANSansWeb/IRANSansWebUltraLight.ttf"
    }

//    Settings
//    {
//        property alias mode: root.hhm_mode
//    }

    //Main UI
    TvnConstants
    {
        id: constant
    }

    TvnSearch
    {
        id: search
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.top: parent.top
        anchors.topMargin: 30
    }

//    TvnFileList
//    {
//        id: file_list
//        anchors.top: search.bottom
//        anchors.bottom: parent.bottom
//        anchors.right: search.right
//    }

    TvnButton
    {
        id: excel_output
        width: 132
        anchors.centerIn: parent
        btnText: "خروجی اکسل"
        btnIcon: "+"
    }


    //Functions
    /*** Call this functions from cpp ***/
    function loginSuccessfully()
    {
        animateHideLogin.start()
    }

    //call this function when have a error and must be
    //set properites `error_text`, `error_duration`.
    function showMessage()
    {
        error_messae.showMessage(error_text, error_duration)
    }

    /*** Call this function from qml ***/
    function signOut()
    {
        login.visible = true
        animateShowLogin.start()
        page.signOut()
    }

    /*** Utilities functions ***/
    function isAdmin()
    {
        return root.username.toLowerCase()==="admin"
    }

    //Slice string from 0 with amount len
    //and add '...' to end text
    function sliceString(text, len)
    {
        if( text.length>len )
        {
            return text.slice(0, len) + "..."
        }
        return text
    }

    //Convert english number to arabic number
    function en2ar(number)
    {
        number = number.toString()
        var arabic_numbers  = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩']//arabic_numbers[0] = 0, arabic_numbers[9] = 9
//        console.log('0:', arabic_numbers[0], ",1:", arabic_numbers[1], ",9:", arabic_numbers[9])
        var english_numbers  = [/0/g, /1/g, /2/g, /3/g, /4/g, /5/g, /6/g, /7/g, /8/g, /9/g]
        for(var i=0; i<10; i++)
        {
            number = number.replace(english_numbers[i], arabic_numbers[i])
        }
        return number
    }

    //Convert arabic number to english number
    function ar2en(number)
    {
        number = number.toString()
        var w_numbers = [/۰/g, /۱/g, /۲/g, /۳/g, /۴/g, /۵/g, /۶/g, /۷/g, /۸/g, /۹/g]
        var arabic_numbers  = [/٠/g, /١/g, /٢/g, /٣/g, /٤/g, /٥/g, /٦/g, /٧/g, /٨/g, /٩/g]
        var en_number
        for(var i=0; i<10; i++)
        {
            number = number.replace(w_numbers[i], i).replace(arabic_numbers[i], i)
        }
        return number
    }
}
