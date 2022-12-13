#ifndef TVN_IMAGE_H
#define TVN_IMAGE_H

#include <QObject>
#include <QProcess>
#include <QVector>

#include "tvn_sharing.h"


#define IMAGE_NAME_EXTRAORDINARY_MEETING    "extraordinary"
#define IMAGE_NAME_GENERAL_MEETING          "general"
#define IMAGE_NAME_LICENCE                  "licence"
#define IMAGE_NAME_REGISTRATION_AD          "registration"

#define IMAGE_NAME_FA_EXTRAORDINARY_MEETING    "مجمع فوق العاده"
#define IMAGE_NAME_FA_GENERAL_MEETING          "مجمع سالیانه"
#define IMAGE_NAME_FA_LICENCE                  "مجوز"
#define IMAGE_NAME_FA_REGISTRATION_AD          "آگهی ثبت"

class TvnImage : public QObject
{
    Q_OBJECT
public:
    explicit TvnImage(QObject *root, TvnSharing *sharing, QObject *parent = nullptr);

signals:


private slots:
    // Detail image slots
    void downloadImage();
    void deleteImage();
    void uploadImage();

    void chooseImage();
    void deleteImages();
    void uploadImages();

    // Process slots
    void finishProcess();
    void errorProcess();

    // View slots
    void cancelDownload();

private:
    QString getImageName(QString type);
    QString getImageNameFa(QString type);
    QString getImagePath(QString type);

    void deleteOneImage();
    void uploadOneImage();

private:
    QObject *root;
    QObject *view;
    QObject *edit;
    QObject *viewImage;
    QObject *editImage;

    TvnSharing *sharing;

    // if successfully download image, open directory
    QString dstDownloadDir;

    QVector<QString> typeDeletedImages;
    QVector<QString> typeUploadImages;
    QString imageMode;
};

#endif // TVN_IMAGE_H
