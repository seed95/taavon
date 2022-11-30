#ifndef TVN_IMAGE_H
#define TVN_IMAGE_H

#include <QObject>


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
    explicit TvnImage(QObject *root, QObject *parent = nullptr);

signals:


private slots:
    void downloadImage(int type);
    void deleteImage(int type);
    void uploadImage(int type);

private:
    QString getImageName(int type);
    QString getImageNameFa(int type);

private:
    QObject *root;
    QObject *viewImage;
    QObject *editImage;


};

#endif // TVN_IMAGE_H
