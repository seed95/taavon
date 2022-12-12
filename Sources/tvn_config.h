#ifndef TVN_CONFIG_H
#define TVN_CONFIG_H

#include <QObject>


#define CONFIG_PATH "tvn.config"

#define JSON_KEY_IMAGE_SHARE_FOLDER_PATH        "image_share_folder_path"
#define JSON_KEY_SHARE_CSV_FILE                 "share_csv_file"
#define JSON_KEY_LOCAL_CSV_FILE                 "local_csv_file"

struct config {
    QString imageShareFolderPath;
    QString shareCsvFile;
    QString localCsvFile;
};

extern config conf;

class TvnConfig : public QObject
{
    Q_OBJECT
public:
    explicit TvnConfig(QObject *parent = nullptr);

private:
    void readConfig();
};


#endif // TVN_CONFIG_H
