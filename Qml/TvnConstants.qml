import QtQuick 2.0

Item
{
    property int tvn_LIST_FILE:     0
    property int tvn_NEW_FILE:      1
    property int tvn_EDIT_FILE:     2
    property int tvn_VIEW_FILE:     3

    // The following values are equal to the values in tvn_constant.h
    property string tvn_PROCESS_NOPE:                      "nope"
    property string tvn_PROCESS_IMAGE_DOWNLOAD:            "image_download"
    property string tvn_PROCESS_IMAGE_UPLOAD:              "image_upload"
    property string tvn_PROCESS_IMAGE_REMOVE:              "image_remove"
    property string tvn_PROCESS_CSV_UPLOAD:                "csv_upload"
    property string tvn_PROCESS_CSV_DOWNLOAD:              "csv_download"

    // The following values are equal to the values in tvn_constant.h
    property string tvn_IMAGE_NOPE:                        "nope"
    property string tvn_IMAGE_EXTRAORDINARY_MEETING:       "extraordinary"
    property string tvn_IMAGE_GENERAL_MEETING:             "general"
    property string tvn_IMAGE_LICENCE:                     "licence"
    property string tvn_IMAGE_REGISTRATION_AD:             "registration"


    property int tvn_DIALOG_NOPE:                       0
    property int tvn_DIALOG_SAVE:                       1
    property int tvn_DIALOG_SURE_DONT_SAVE_CHANGES:     2
    property int tvn_DIALOG_DOWNLOAD:                   3
    property int tvn_DIALOG_UPLOAD:                     4
    property int tvn_DIALOG_DELETE:                     5
    property int tvn_DIALOG_SAVE_CHANGES:               6
    property int tvn_DIALOG_DOWNLOAD_CSV:               7

    property int tvn_SEARCH_FILE_CODE:                  1
    property int tvn_SEARCH_FILE_NAME:                  2
    property int tvn_SEARCH_REGISTRATION_NUMBER:        3


    // Combo box items
    property var tvn_COMBO_STATUS_ITEMS:            ["منحل", "غیر فعال","فعال","در دست اجرا"]
    property var tvn_COMBO_KEEPING_PLACE_ITEMS:     ["بایگانی/دایی","دایی","بایگانی"]

    property var tvn_REGEX_ALL_CHARACTERS_EXCEPT_COMMA: RegExpValidator { regExp: /^[^,]*$/ }
}
