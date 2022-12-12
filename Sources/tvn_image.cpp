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
#include <QUrl>
#include <QDesktopServices>


TvnImage::TvnImage(QObject *root, TvnSharing *sharing, QObject *parent) : QObject(parent)
{
    this->root = root;

    // View UI
    view = root->findChild<QObject*>("ViewFile");
    QObject *viewDetail = view->findChild<QObject*>("Detail");
    viewImage = viewDetail->findChild<QObject*>("DetailImage");

    // View signals
    connect(view, SIGNAL(cancelDownload()), this, SLOT(cancelDownload()));
    connect(viewImage, SIGNAL(downloadImage()), this, SLOT(downloadImage()));

    // Edit UI
    edit = root->findChild<QObject*>("EditFile");
    QObject *editDetail = edit->findChild<QObject*>("Detail");
    editImage = editDetail->findChild<QObject*>("DetailImage");

    // edit signals
//    connect(edit, SIGNAL(cancelUpload()), this, SLOT(cancelUpload()));
//    connect(editImage, SIGNAL(uploadImage()), this, SLOT(uploadImage()));
//    connect(edit, SIGNAL(cancelDelete()), this, SLOT(cancelDelete()));
//    connect(editImage, SIGNAL(deleteImage()), this, SLOT(deleteImage()));
    connect(editImage, SIGNAL(chooseImage()), this, SLOT(chooseImage()));
    connect(edit, SIGNAL(deleteImages()), this, SLOT(deleteImages()));
    connect(edit, SIGNAL(uploadImages()), this, SLOT(uploadImages()));


    // Sharing
    connect(sharing, SIGNAL(finish()), this, SLOT(finishProcess()));
    connect(sharing, SIGNAL(error()), this, SLOT(errorProcess()));
    this->sharing = sharing;


//    uploadImage(IMAGE_LICENCE);
//    deleteImage(IMAGE_LICENCE);
//    downloadImage(IMAGE_REGISTRATION_AD);
//    sharing->downlaod("page3.xlsx", "داداشی", "sajad.txt", "/home/sajad/taavon");
//    share->upload("Taavon.pro", "/home/sajad/taavon", "sajad.txt", "داداشی");
}

void TvnImage::downloadImage()
{
    QString imageType = TvnUtility::getImageType(root);
    // Get image filename
    QString caption = "ذخیره عکس " + getImageNameFa(imageType);
    dstDownloadDir = QFileDialog::getExistingDirectory(NULL, caption, "", QFileDialog::ShowDirsOnly);
    if (dstDownloadDir.isEmpty())
    {
        return;
    }

    // Show download dialog
    QMetaObject::invokeMethod(view, "showDownloadDialog");

    // Make src filename and directory
    QString srcFilename = getImageName(imageType) + ".jpg";
    QString srcDir = conf.imageShareFolderPath + "/" + TvnUtility::getFileCode(root) + "/";

    // Make destination filename
    QString destFilename = getImageNameFa(imageType) + " - ";
    if (imageType==IMAGE_EXTRAORDINARY_MEETING || imageType==IMAGE_GENERAL_MEETING)
    {
        destFilename = destFilename + TvnUtility::getDateOfLastMeeting(root).replace("/", "") + " - ";
    }
    destFilename = destFilename + TvnUtility::getFileName(root) + ".jpg";

    // Download from share folder
    sharing->downlaod(srcFilename, srcDir, destFilename, dstDownloadDir);
}

void TvnImage::deleteImage()
{
    // Show delete dialog
    QMetaObject::invokeMethod(edit, "showDeleteDialog");

    QString imageType = TvnUtility::getImageType(root);
    // Make src directory and filename
    QString srcDir = conf.imageShareFolderPath + "/" + TvnUtility::getFileCode(root);
    QString srcFilename = getImageName(imageType) + ".jpg";

    sharing->remove(srcFilename, srcDir);
}

void TvnImage::uploadImage()
{
    QString imageType = TvnUtility::getImageType(root);
    // Get image filename
    QString caption = "انتخاب عکس " + getImageNameFa(imageType);
    QString filter = "Images (*.jpg *.jpeg)";
    QString srcFilename = QFileDialog::getOpenFileName(NULL, caption, "", filter);
    if (srcFilename.isEmpty())
    {
        return;
    }
    QFileInfo srcInfo(srcFilename);

    // Show upload dialog
    QMetaObject::invokeMethod(edit, "showUploadDialog");

    // Make dest directory and filename
    QString destDir = conf.imageShareFolderPath + "/" + TvnUtility::getFileCode(root);
    QString destFilename = getImageName(imageType) + ".jpg";

    sharing->upload(srcInfo.fileName(), srcInfo.absolutePath(), destFilename, destDir);
}

void TvnImage::chooseImage()
{
    QString imageType = TvnUtility::getImageType(root);
    // Get image filename
    QString caption = "انتخاب عکس " + getImageNameFa(imageType);
    QString filter = "Images (*.jpg *.jpeg)";
    QString srcFilename = QFileDialog::getOpenFileName(NULL, caption, "", filter);
//    if (srcFilename.isEmpty())
//    {
//        return;
//    }
    QMetaObject::invokeMethod(root, "saveImagePath", Q_ARG(QString, srcFilename));
}

void TvnImage::deleteImages()
{
    typeDeletedImages.clear();
    QString extraordinaryDeleted = TvnUtility::getExtraordinaryDeleted(root);
    if (extraordinaryDeleted=="true")
    {
        typeDeletedImages.append(IMAGE_EXTRAORDINARY_MEETING);
    }

    QString generalDeleted = TvnUtility::getGeneralDeleted(root);
    if (generalDeleted=="true")
    {
        typeDeletedImages.append(IMAGE_GENERAL_MEETING);
    }

    QString licenceDeleted = TvnUtility::getLicenceDeleted(root);
    if (licenceDeleted=="true")
    {
        typeDeletedImages.append(IMAGE_LICENCE);
    }

    QString registrationDeleted = TvnUtility::getRegistrationDeleted(root);
    if (registrationDeleted=="true")
    {
        typeDeletedImages.append(IMAGE_REGISTRATION_AD);
    }

    deleteOneImage();
}

void TvnImage::uploadImages()
{
    typeUploadImages.clear();
    QString extraordinaryPath = TvnUtility::getExtraordinaryPath(root);
    if (!extraordinaryPath.isEmpty())
    {
        typeUploadImages.append(IMAGE_EXTRAORDINARY_MEETING);
    }

    QString generalPath = TvnUtility::getGeneralPath(root);
    if (!generalPath.isEmpty())
    {
        typeUploadImages.append(IMAGE_GENERAL_MEETING);
    }

    QString licencePath = TvnUtility::getLicencePath(root);
    if (!generalPath.isEmpty())
    {
        typeUploadImages.append(IMAGE_LICENCE);
    }

    QString registrationPath = TvnUtility::getRegistrationPath(root);
    if (!generalPath.isEmpty())
    {
        typeUploadImages.append(IMAGE_REGISTRATION_AD);
    }
}


void TvnImage::deleteOneImage()
{
    if (typeDeletedImages.isEmpty())
    {
        QMetaObject::invokeMethod(root, "deleteImagesSuccessfully");
        return;
    }
    imageMode = typeDeletedImages.takeFirst();
    // Make src directory and filename
    QString srcDir = conf.imageShareFolderPath + "/" + TvnUtility::getFileCode(root);
    QString srcFilename = getImageName(imageMode) + ".jpg";

    sharing->remove(srcFilename, srcDir);
}

void TvnImage::uploadOneImage()
{
    if (typeUploadImages.isEmpty())
    {
        QMetaObject::invokeMethod(root, "deleteImagesSuccessfully");
        return;
    }
    imageMode = typeUploadImages.takeFirst();

    QFileInfo srcInfo(getImagePath(imageMode));

    // Make dest directory and filename
    QString destDir = conf.imageShareFolderPath + "/" + TvnUtility::getFileCode(root);
    QString destFilename = getImageName(imageMode) + ".jpg";

    sharing->upload(srcInfo.fileName(), srcInfo.absolutePath(), destFilename, destDir);
}

void TvnImage::finishProcess()
{
    QString processType = TvnUtility::getProcessType(root);
    if (processType==PROCESS_IMAGE_DOWNLOAD)
    {
        QMetaObject::invokeMethod(view, "hideDialog");
        // Open image folder
        QDesktopServices::openUrl(QUrl::fromLocalFile(dstDownloadDir));
    }
    else if (processType==PROCESS_IMAGE_UPLOAD)
    {
        uploadOneImage();
//        QMetaObject::invokeMethod(edit, "hideDialog");
//        QMetaObject::invokeMethod(root, "uploadSuccessfully");
    }
    else if (processType==PROCESS_IMAGE_REMOVE)
    {
        deleteOneImage();
//        QMetaObject::invokeMethod(edit, "hideDialog");
//        QMetaObject::invokeMethod(root, "deleteSuccessfully");
    }
}

void TvnImage::errorProcess()
{
    QString processType = TvnUtility::getProcessType(root);
    if (processType==PROCESS_IMAGE_DOWNLOAD)
    {
        QMetaObject::invokeMethod(view, "hideDialog");
        TvnUtility::setError(view, ERROR_MESSAGE_DOWNLOAD_IMAGE);
    }
    else if (processType==PROCESS_IMAGE_UPLOAD)
    {
        QMetaObject::invokeMethod(edit, "hideDialog");
        TvnUtility::setError(edit, ERROR_MESSAGE_UPLOAD_CSV);
    }
    else if (processType==PROCESS_IMAGE_REMOVE)
    {
        QMetaObject::invokeMethod(edit, "hideDialog");
        TvnUtility::setError(edit, ERROR_MESSAGE_UPLOAD_CSV);
    }
}

void TvnImage::cancelDownload()
{
    sharing->cancelProcess();
    QMetaObject::invokeMethod(view, "hideDialog");
}

void TvnImage::cancelUpload()
{
    sharing->cancelProcess();
    QMetaObject::invokeMethod(edit, "hideDialog");
}

void TvnImage::cancelDelete()
{
    sharing->cancelProcess();
    QMetaObject::invokeMethod(edit, "hideDialog");
}

QString TvnImage::getImageName(QString type)
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

QString TvnImage::getImageNameFa(QString type)
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

QString TvnImage::getImagePath(QString type)
{
    if (type==IMAGE_EXTRAORDINARY_MEETING)
    {
        return TvnUtility::getExtraordinaryPath(root);
    }
    else if (type==IMAGE_GENERAL_MEETING)
    {
        return TvnUtility::getGeneralPath(root);
    }
    else if (type==IMAGE_LICENCE)
    {
        return TvnUtility::getLicencePath(root);
    }
    else // type == IMAGE_REGISTRATION_AD
    {
        return TvnUtility::getRegistrationPath(root);
    }
}
