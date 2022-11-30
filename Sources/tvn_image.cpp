#include "tvn_image.h"
#include "tvn_config.h"
#include "tvn_utility.h"
#include "tvn_constant.h"
#include "tvn_csv.h"

#include <QDebug>
#include <QFileDialog>
#include <QFile>
#include <QFileInfo>
#include <QDir>
#include <QDateTime>

TvnImage::TvnImage(QObject *root, QObject *parent) : QObject(parent)
{
    this->root = root;

    QObject *view = root->findChild<QObject*>("ViewFile");
    QObject *viewDetail = view->findChild<QObject*>("Detail");
    viewImage = viewDetail->findChild<QObject*>("DetailImage");

    QObject *edit = root->findChild<QObject*>("EditFile");
    QObject *editDetail = edit->findChild<QObject*>("Detail");
    editImage = editDetail->findChild<QObject*>("DetailImage");

    connect(viewImage, SIGNAL(downloadImage(int)), this, SLOT(downloadImage(int)));

    connect(editImage, SIGNAL(deleteImage(int)), this, SLOT(deleteImage(int)));
    connect(editImage, SIGNAL(uploadImage(int)), this, SLOT(uploadImage(int)));
}

void TvnImage::downloadImage(int type)
{
    // Get image filename
    QString caption = "ذخیره عکس " + getImageNameFa(type);
    QString destDir = QFileDialog::getExistingDirectory(NULL, caption, "", QFileDialog::ShowDirsOnly);
    if (destDir=="")
    {
        return;
    }

    // Make source filename
    QString srcFilename = conf.shareFolderPath + "/" +
            TvnUtility::getFileCode(root) + "/" +
            getImageName(type) + ".jpg";

    // Make destination filename
    QString destFilename = destDir + "/" + getImageNameFa(type) + " - ";
    if (type==IMAGE_EXTRAORDINARY_MEETING || type==IMAGE_GENERAL_MEETING)
    {
        destFilename = destFilename + TvnUtility::getDateOfLastMeeting(root).replace("/", "") + " - ";
    }
    destFilename = destFilename + TvnUtility::getFileName(root) + ".jpg";

    if (!QFile::copy(srcFilename, destFilename))
    {
        TvnUtility::log("downloadImage:: copy failed <dest: " + destFilename + ", src: " + srcFilename + ">");
        TvnUtility::setError(root, ERROR_MESSAGE_DOWNLOAD_IMAGE);
        return;
    }
}

void TvnImage::deleteImage(int type)
{
    QString filePath = conf.shareFolderPath + "/" + TvnUtility::getFileCode(root);

    // Make source filename
    QString srcFilename = filePath + "/" + getImageName(type) + ".jpg";

    // Make destination path
    QString destDir = filePath + "/delete/";
    QDir dir("");
    if (!dir.mkpath(destDir))
    {
        TvnUtility::log("deleteImage:: make image path failed <" + destDir + ">");
        TvnUtility::setError(root, ERROR_MESSAGE_DELETE_IMAGE);
        return;
    }

    // Make destination filename
    QLocale en_localce(QLocale::English);
    QString date = en_localce.toString(QDateTime::currentDateTime(), "--yyyy-MM-dd--hh-mm-ss");
    QString destFilename = destDir + getImageName(type) + date + ".jpg";

    // Copy
    if (!QFile::copy(srcFilename, destFilename))
    {
        TvnUtility::log("deleteImage:: copy failed <dest: " + destFilename + ", src: " + srcFilename + ">");
        TvnUtility::setError(root, ERROR_MESSAGE_DELETE_IMAGE);
        return;
    }

    if (!QFile::remove(srcFilename))
    {
        TvnUtility::log("deleteImage:: remove failed <" + srcFilename + ">");
        TvnUtility::setError(root, ERROR_MESSAGE_DELETE_IMAGE);
        return;
    }

    // Save hasImage to false for type
    bool ok = TvnCsv::SaveImageChanges(root, type, false);
    if (!ok)
    {
        TvnUtility::setError(root, ERROR_MESSAGE_DELETE_IMAGE);
        return;
        // TODO must be undo remove
    }


    QMetaObject::invokeMethod(root, "deleteSuccessfully", Q_ARG(QVariant, type));
}

void TvnImage::uploadImage(int type)
{
    // Get image filename
    QString caption = "انتخاب عکس " + getImageNameFa(type);
    QString filter = "Images (*.jpg *.jpeg)";
    QString srcFilename = QFileDialog::getOpenFileName(NULL, caption, "", filter);
    if (srcFilename=="")
    {
        return;
    }

    // Make destination path
    QString destDir = conf.shareFolderPath + "/" + TvnUtility::getFileCode(root);
    QDir dir("");
    if (!dir.mkpath(destDir))
    {
        TvnUtility::log("uploadImage:: make image path failed <" + destDir + ">");
        TvnUtility::setError(root, ERROR_MESSAGE_UPLOAD_IMAGE);
        return;
    }

    QString destFilename = destDir + "/" + getImageName(type) + ".jpg";

    // Check image exist
    if(QFileInfo::exists(destFilename))
    {
        TvnUtility::log("uploadImage:: image exist <dest: " + destFilename + ">");
        TvnUtility::setError(root, ERROR_MESSAGE_UPLOAD_IMAGE);
        return;
    }

    // Copy
    if (!QFile::copy(srcFilename, destFilename))
    {
        TvnUtility::log("uploadImage:: copy image failed <dest: " + destFilename + ", src: " + srcFilename + ">");
        TvnUtility::setError(root, ERROR_MESSAGE_UPLOAD_IMAGE);
        return;
    }

    // Save hasImage to true for type
    bool ok = TvnCsv::SaveImageChanges(root, type, true);
    if (!ok)
    {
        TvnUtility::setError(root, ERROR_MESSAGE_UPLOAD_IMAGE);
        return;
        // TODO must be remove
    }

    QMetaObject::invokeMethod(root, "uploadSuccessfully", Q_ARG(QVariant, type));
}

QString TvnImage::getImageName(int type)
{
    if ( type == IMAGE_EXTRAORDINARY_MEETING )
    {
        return IMAGE_NAME_EXTRAORDINARY_MEETING;
    }
    else if ( type == IMAGE_GENERAL_MEETING )
    {
        return IMAGE_NAME_GENERAL_MEETING;
    }
    else if ( type == IMAGE_LICENCE )
    {
        return IMAGE_NAME_LICENCE;
    }
    else // type == IMAGE_REGISTRATION_AD
    {
        return IMAGE_NAME_REGISTRATION_AD;
    }
}

QString TvnImage::getImageNameFa(int type)
{
    if ( type == IMAGE_EXTRAORDINARY_MEETING )
    {
        return IMAGE_NAME_FA_EXTRAORDINARY_MEETING;
    }
    else if ( type == IMAGE_GENERAL_MEETING )
    {
        return IMAGE_NAME_FA_GENERAL_MEETING;
    }
    else if ( type == IMAGE_LICENCE )
    {
        return IMAGE_NAME_FA_LICENCE;
    }
    else // type == IMAGE_REGISTRATION_AD
    {
        return IMAGE_NAME_FA_REGISTRATION_AD;
    }
}
