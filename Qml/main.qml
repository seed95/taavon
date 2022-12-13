import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.4
import Qt.labs.settings 1.0

Window
{
    id: root

    /***** Used this variables in qml/cpp *****/
    property string processType: constant.tvn_PROCESS_NOPE
    property string imageType: constant.tvn_IMAGE_NOPE
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

    // Variables used to handle images during editing (delete-upload)
    // To save the path of the selected images in the local for upload
    property string extraordinaryPath: ""
    property string generalPath: ""
    property string licencePath: ""
    property string registrationPath: ""
    // To know which iamges have been deleted in the share folder
    property bool extraordinaryDeleted: false
    property bool generalDeleted: false
    property bool licenceDeleted: false
    property bool registrationDeleted: false

    /***** Used this variables in qml *****/
    // show edit/view/new/list file based on mode
    property int pageMode: constant.tvn_LIST_FILE

    // any variable has changed in the edit page
    property bool hasChanged: false

    property var statusItems: ["منحل", "غیر فعال","فعال","در دست اجرا"]
    property var keepingPlaceItems: ["بایگانی/دایی","دایی","بایگانی"]

    /***** Set this variables in cpp *****/
    //Error properties
    property string errorMessage: ""

    property bool isEditable: false


    visible: true
    width: 1300
    height: 800
    minimumHeight: height
    maximumHeight: height
    minimumWidth: width
    maximumWidth: width
    color: "#2f343f"
    title: "مدیریت پرونده های تعاونی"

    onPageModeChanged: root.updateFocus()
    onErrorMessageChanged:
    {
        if (root.errorMessage!=="")
        {
            root.updateFocus()
        }
    }

//    onFocusObjectChanged: console.log("focus", activeFocusItem)

//    onErrorMessageChanged: console.log("error message", errorMessage)
//    onHasChangedChanged: console.log('has changed', hasChanged)

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
//        property alias selectedStatus: search.selectedStatus
//        property alias selectedKeepingPlace: search.selectedKeepingPlace
//    }

    MouseArea
    {
        anchors.fill: parent
        enabled: list.windowIsActive()
        onClicked:
        {
            console.log("onClicked list file")
            root.updateFocus()
//            list.forceActiveFocus()
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
        searchIsActive: list.windowIsActive()
    }

    TvnHeader
    {
        id: header
        x: 25
        y: 82
    }

    TvnListFile
    {
        id: list
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
        isActive: list.windowIsActive()
        btnText: "خروجی اکسل"
        btnIcon: "\uf56e"
        onClickButton: console.log("excel output")
    }

    TvnButton
    {
        id: register_new_file
        width: 145
        x: 170
        y: 750
        isActive: list.windowIsActive()
        btnText: "ثبت پرونده جدید"
        btnIcon: "+"
        onClickButton: console.log("new file")
    }

    TvnError
    {
        id: error
        visible: root.errorMessage !== ""
    }


    // Functions
    /*** Call this functions from cpp ***/
    function saveImagePath(path)
    {
        root.hasChanged = true
        if (root.imageType===constant.tvn_IMAGE_EXTRAORDINARY_MEETING)
        {
            root.extraordinaryMeetingHasImage = true
            root.extraordinaryPath = path
        }
        else if (root.imageType===constant.tvn_IMAGE_GENERAL_MEETING)
        {
            root.generalMeetingHasImage = true
            root.generalPath = path
        }
        else if (root.imageType===constant.tvn_IMAGE_LICENCE)
        {
            root.licenceHasImage = true
            root.licencePath = path
        }
        else if (root.imageType===constant.tvn_IMAGE_REGISTRATION_AD)
        {
            root.registrationAdHasImage = true
            root.registrationPath = path
        }
    }

    /*** Call this functions from qml ***/
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
            list.forceFocus()
        }
    }


    /*** Utilities functions ***/

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

    //Convert persian/arabic number to english number
    function fa2en(number)
    {
        number = number.toString()
        var persian_numbers = [/۰/g, /۱/g, /۲/g, /۳/g, /۴/g, /۵/g, /۶/g, /۷/g, /۸/g, /۹/g]
        var arabic_numbers  = [/٠/g, /١/g, /٢/g, /٣/g, /٤/g, /٥/g, /٦/g, /٧/g, /٨/g, /٩/g]
        var en_number
        for(var i=0; i<10; i++)
        {
            number = number.replace(persian_numbers[i], i).replace(arabic_numbers[i], i)
        }
        return number
    }


    function getStatusIndex(status)
    {
        for (var i=0; i<root.statusItems.length; i++)
        {
            if (status===root.statusItems[i])
            {
                return i
            }
        }
    }

    function getKeepingPlaceIndex(keepingPlace)
    {
        for (var i=0; i<root.keepingPlaceItems.length; i++)
        {
            if (keepingPlace===root.keepingPlaceItems[i])
            {
                return i
            }
        }
    }

}
