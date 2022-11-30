#include "tvn_config.h"
#include "tvn_utility.h"

#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QString>


config conf;

TvnConfig::TvnConfig(QObject *parent) : QObject(parent)
{
    readConfig();
}

void TvnConfig::readConfig()
{
    QFile file(CONFIG_PATH);
    if (!file.open(QIODevice::ReadOnly))
    {
        throw QString("read config file error (%1)").arg(file.errorString());
    }

    QByteArray bytes = file.readAll();
    file.close();

    QJsonParseError jsonError;
    QJsonDocument document = QJsonDocument::fromJson(bytes, &jsonError);
    if (jsonError.error != QJsonParseError::NoError)
    {
        throw QString("read config file error (%1)").arg(jsonError.errorString());
    }
    if (!document.isObject())
    {
        throw QString("read config file error (invalid json object)");
    }
    QJsonObject jsonObj = document.object();
    conf.csvFilePath = jsonObj.value(JSON_KEY_CSV_FILE_PATH).toString();
    conf.shareFolderPath = jsonObj.value(JSON_KEY_SHARE_FOLDER_PATH).toString();
}
