#ifndef TVN_CONFIG_H
#define TVN_CONFIG_H

#include <QObject>


#define CONFIG_PATH "tvn.config"

#define JSON_KEY_SHARE_FOLDER                   "share_folder"
#define JSON_KEY_IMAGE_SHARE_FOLDER_PATH        "image_share_folder_path"
#define JSON_KEY_SHARE_CSV_FILE                 "share_csv_file"
#define JSON_KEY_LOCAL_CSV_FILE                 "local_csv_file"
#define JSON_KEY_EDITABLE                       "editable"

struct config {
    QString shareFolder;
    QString imageShareFolderPath;
    QString shareCsvFile;
    QString localCsvFile;
    bool editable;
};

extern config conf;

class TvnConfig : public QObject
{
    Q_OBJECT
public:
    explicit TvnConfig(QObject *root, QObject *parent = nullptr);

private:
    void readConfig();

private:
    QObject *root;
};


#endif // TVN_CONFIG_H
