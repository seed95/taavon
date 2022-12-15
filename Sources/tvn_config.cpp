#include "tvn_config.h"
#include "tvn_utility.h"
#include "tvn_constant.h"

#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QString>
#include <QDebug>


config conf;

TvnConfig::TvnConfig(QObject *root, QObject *parent) : QObject(parent)
{
    this->root = root;
    readConfig();
}

void TvnConfig::readConfig()
{
    QFile file(CONFIG_PATH);
    if (!file.open(QIODevice::ReadOnly))
    {
        TvnUtility::log(QString("readConfig:: load config file error (%1), path (%2)")
                        .arg(file.errorString())
                        .arg(CONFIG_PATH));
        TvnUtility::setError(root, ERROR_MESSAGE_LOAD_CONFIG);
        return;
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
    conf.shareFolder = jsonObj.value(JSON_KEY_SHARE_FOLDER).toString();
    conf.imageShareFolderPath = jsonObj.value(JSON_KEY_IMAGE_SHARE_FOLDER_PATH).toString();
    conf.shareCsvFile = jsonObj.value(JSON_KEY_SHARE_CSV_FILE).toString();
    conf.localCsvFile = jsonObj.value(JSON_KEY_LOCAL_CSV_FILE).toString();
    conf.editable = jsonObj.value(JSON_KEY_EDITABLE).toBool();
}
