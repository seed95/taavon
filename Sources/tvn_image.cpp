#include "tvn_image.h"
#include "tvn_config.h"
#include "tvn_utility.h"

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
        TvnUtility::log("downlaod:: copy failed <dest: " + destFilename + ", src: " + srcFilename + ">");
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
        TvnUtility::log("delete:: make path failed <" + destDir + ">");
    }

    // Make destination filename
    QLocale en_localce(QLocale::English);
    QString date = en_localce.toString(QDateTime::currentDateTime(), "--yyyy-MM-dd--hh-mm-ss");
    QString destFilename = destDir + getImageName(type) + date + ".jpg";

    // Copy
    if (!QFile::copy(srcFilename, destFilename))
    {
        TvnUtility::log("delete:: copy failed <dest: " + destFilename + ", src: " + srcFilename + ">");
        return;
    }

    if (!QFile::remove(srcFilename))
    {
        TvnUtility::log("delete:: remove failed <" + srcFilename + ">");
        return;
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
        TvnUtility::log("upload:: make path failed <" + destDir + ">");
    }

    // Copy
    QString destFilename = destDir + "/" + getImageName(type) + ".jpg";
    if (!QFile::copy(srcFilename, destFilename))
    {
        TvnUtility::log("upload:: copy failed <dest: " + destFilename + ", src: " + srcFilename + ">");
        return;
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
