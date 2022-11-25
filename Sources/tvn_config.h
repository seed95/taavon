#ifndef TVN_CONFIG_H
#define TVN_CONFIG_H

#include <QObject>


#define CONFIG_PATH "tvn.config"

#define JSON_KEY_CSV_FILE_PATH "csv_file_path"

struct config {
    QString csvFilePath;
};

// TODO check extern
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
