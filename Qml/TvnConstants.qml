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
    property string tvn_PROCESS_UPLOAD_CSV:                "upload_csv"

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
}
