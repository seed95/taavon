import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.4
import Qt.labs.settings 1.0

Window
{
    id: root

    /***** Set this variables in qml and read in cpp *****/
    // Variables that show in edit or view page
    property int selectedFileIndex: 0
    property string fileCode: ""
    property string keepingPlace: ""
    property string fileStatus: ""
    property string ledgerBinder: ""
    property string numberOfCover: ""
    property string fileName: ""
    property string registrationNumber: ""
    property string dateOfRegistration: ""
    property string nationalId: ""
    property string dateOfLastMeeting: ""
    property string numberOfPrimaryMembers: ""
    property string numberOfCurrentMembers: ""
    property string valuePerShare: ""
    property string startingCapital: ""
    property string currentCapital: ""
    property string phoneNumber: ""
    property string mobileNumber: ""
    property string officeAddress: ""
    property string ceoName: ""
    property string chairmanName: ""
    property string viceName: ""
    property string secretaryName: ""
    property bool extraordinaryMeetingHasImage: false
    property bool generalMeetingHasImage: false
    property bool licenceHasImage: false
    property bool registrationAdHasImage: false

    // show edit/view/new/list file based on mode
    property int pageMode: constant.tvn_LIST_FILE

    /***** Set this variables in cpp *****/
    //Error properties
    property string errorMessage: "آپلود عکس با مشکل مواجه شد"

    // cpp signals
    signal updateImageInCsv()
    signal saveChanges()

    visible: true
    width: 1300
    height: 800
    minimumHeight: height
    maximumHeight: height
    minimumWidth: width
    maximumWidth: width
    color: "#2f343f"
    title: "مدیریت پرونده های تعاونی"

//    onFocusObjectChanged: console.log("focus", activeFocusItem)

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

    MouseArea
    {
        anchors.fill: parent
        onClicked:
        {
            list_file.forceActiveFocus()
        }
    }

    //Main UI
    TvnConstants
    {
        id: constant
    }

    TvnSearch
    {
        id: search
        x: 25
        y: 14
        z: 1
    }

    TvnHeader
    {
        id: header
        x: 25
        y: 82
    }

    TvnListFile
    {
        id: list_file
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 25
        anchors.top: header.bottom
        anchors.bottom: excel_output.top
        focus: true
        objectName: "ListFile"
    }

    TvnViewFile
    {
        id: view
        visible: root.pageMode === constant.tvn_VIEW_FILE
        objectName: "ViewFile"
    }

    TvnEditFile
    {
        id: edit
        visible: root.pageMode === constant.tvn_EDIT_FILE
        objectName: "EditFile"
    }

    TvnButton
    {
        id: excel_output
        width: 135
        x: 20
        y: 750
        btnText: "خروجی اکسل"
        btnIcon: "\uf56e"
        textWidth: 110
        onClickButton: console.log("excel output")
    }

    TvnButton
    {
        id: register_new_file
        width: 145
        x: 170
        y: 750
        btnText: "ثبت پرونده جدید"
        btnIcon: "+"
        textWidth: 128
        onClickButton: console.log("new file")
    }

    TvnError
    {
        id: error
        visible: root.errorMessage !== ""
    }

    //Functions
    /*** Call this functions from cpp ***/
    function deleteSuccessfully(type)
    {
        updateHasImage(type, false)
    }

    function uploadSuccessfully(type)
    {
        updateHasImage(type, true)
    }

    function saveChangesSuccessfully()
    {
        root.pageMode = constant.tvn_LIST_FILE
        list_file.updateFile()
    }

    function saveImageChangesSuccessfully()
    {
        list_file.updateImageFile()
    }

    /*** Call this functions from qml ***/

    /*** Utilities functions ***/
    function updateFocus()
    {
        if (root.pageMode === constant.tvn_VIEW_FILE)
        {
            view.forceFocus()
        }
        else if (root.pageMode === constant.tvn_EDIT_FILE)
        {
            edit.forceFocus()
        }
        else
        {
            list_file.forceActiveFocus()
        }
    }

    // updateHasImage update hasImage fields
    // extraordinaryMeetingHasImage, generalMeetingHasImage, licenceHasImage, registrationAdHasImage
    function updateHasImage(type, value)
    {
        if (type===constant.tvn_IMAGE_EXTRAORDINARY_MEETING)
        {
            root.extraordinaryMeetingHasImage = value
        }
        else if (type===constant.tvn_IMAGE_GENERAL_MEETING)
        {
            root.generalMeetingHasImage = value
        }
        else if (type===constant.tvn_IMAGE_LICENCE)
        {
            root.licenceHasImage = value
        }
        else if (type===constant.tvn_IMAGE_REGISTRATION_AD)
        {
            root.registrationAdHasImage = value
        }

        updateImageInCsv()
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
