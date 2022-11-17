import QtQuick 2.0

Item
{

    property int    hhm_NO_SELECTED_ITEM:       -1
    property string hhm_NO_SELECTED_MESSAGE:    "-1"

    property int id_DOC_STATUS_SUCCESS: 1
    property int id_DOC_STATUS_PENDING: 2
    property int id_DOC_STATUS_FAILED:  3

    property int hhm_TABLE_NEW_MODE:            1
    property int hhm_TABLE_VIEW_INBOX_MODE:     2
    property int hhm_TABLE_VIEW_OUTBOX_MODE:    3

    property int hhm_MESSAGE_MODE:      0
    property int hhm_DOCUMENT_MODE:     1
    property int hhm_PROFILE_MODE:      2
    property int hhm_ADMINPANEL_MODE:   3

    property int hhm_MTIT_DEFAULT:      0//Message TextInput Type
    property int hhm_MTIT_USERNAME:     1//Message TextInput Type

    property int hhm_SIDEBAR_NONE_STATE :       0
    property int hhm_SIDEBAR_INBOX_STATE :      1
    property int hhm_SIDEBAR_OUTBOX_STATE:      2

    //Sync With hhm_config.h
    property int hhm_TAG_USER:          1
    property int hhm_TAG_DEPARTMENT:    2

    property int hhm_ATTACHMENT_NONE_MODE:         0
    property int hhm_ATTACHMENT_UPLOAD_MODE:       1
    property int hhm_ATTACHMENT_DOWNLOAD_MODE:     2

    property int hhm_MESSAGE_NONE_STATE:        0
    property int hhm_MESSAGE_NEW_STATE:         1
    property int hhm_MESSAGE_VIEW_STATE:        2
    property int hhm_MESSAGE_REPLY_STATE:       3

    property int hhm_DOCUMENT_NONE_STATE:       0
    property int hhm_DOCUMENT_NEW_STATE:        1
    property int hhm_DOCUMENT_VIEW_STATE:       2

    property string hhm_TEXT_DOC_STATUS_SUCCESS: "تمت بنجاح"
    property string hhm_TEXT_DOC_STATUS_PENDING: "غير مقروءة"
    property string hhm_TEXT_DOC_STATUS_FAILED:  "رفض"

}
