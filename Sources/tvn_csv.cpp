#include "tvn_csv.h"
#include "tvn_config.h"
#include "tvn_utility.h"

#include <QFile>
#include <QStringList>
#include <QDebug>
#include <QQmlProperty>

TvnCsv::TvnCsv(QObject *root, QObject *parent) : QObject(parent)
{
    list = root->findChild<QObject*>("FileList");
}

void TvnCsv::LoadCsv()
{
    QFile file(conf.csvFilePath);
    if (!file.open(QIODevice::ReadOnly)) {
        TvnUtility::log(QString("load csv file error (%1)").arg(file.errorString()));
        //TODO handle error and show in ui
        return;
    }

    while (!file.atEnd()) {
        QByteArray line = file.readLine();
        QStringList wordList = QString(line).split(",");

        qDebug() << wordList;
        if (wordList.length()!=HEADER_INDEX_TOTAL_NUMBER)
        {
            TvnUtility::log(QString("invalid csv header length, acctual: %s - desierd: %s)").
                            arg(wordList.length(), HEADER_INDEX_TOTAL_NUMBER));
            continue;
        }

        QQmlProperty::write(list, "fileCode", wordList[HEADER_INDEX_FILE_CODE]);
        QQmlProperty::write(list, "keepingPlace", wordList[HEADER_INDEX_KEEPING_PLACE]);
        QQmlProperty::write(list, "status", wordList[HEADER_INDEX_STATUS]);
        QQmlProperty::write(list, "ledgerBinder", wordList[HEADER_INDEX_LEDGER_BINDER]);
        QQmlProperty::write(list, "numberOfCover", wordList[HEADER_INDEX_NUMBER_OF_COVER]);
        QQmlProperty::write(list, "fileName", wordList[HEADER_INDEX_FILE_NAME]);
        QQmlProperty::write(list, "registrationNumber", wordList[HEADER_INDEX_REGISTRATION_NUMBER]);
        QQmlProperty::write(list, "dateOfLastMeeting", wordList[HEADER_INDEX_DATE_OF_LAST_MEETING]);
        QQmlProperty::write(list, "nationalId", wordList[HEADER_INDEX_NATIONAL_ID]);
        QQmlProperty::write(list, "ceoName", wordList[HEADER_INDEX_CEO_NAME]);
        QQmlProperty::write(list, "mobileNumber", wordList[HEADER_INDEX_MOBILE_NUMBER]);
        QQmlProperty::write(list, "dateOfRegistration", wordList[HEADER_INDEX_DATE_OF_REGISTRATION]);
        QQmlProperty::write(list, "numberOfPrimaryMembers", wordList[HEADER_INDEX_NUMBER_OF_PRIMARY_MEMBERS]);
        QQmlProperty::write(list, "numberOfCurrentMembers", wordList[HEADER_INDEX_NUMBER_OF_CURRENT_MEMBERS]);
        QQmlProperty::write(list, "valuePerShare", wordList[HEADER_INDEX_VALUE_PER_SHARE]);
        QQmlProperty::write(list, "startingCapital", wordList[HEADER_INDEX_STARTING_CAPITAL]);
        QQmlProperty::write(list, "currentCapital", wordList[HEADER_INDEX_CURRENT_CAPITAL]);
        QQmlProperty::write(list, "chairmanName", wordList[HEADER_INDEX_CHAIRMAN_NAME]);
        QQmlProperty::write(list, "viceName", wordList[HEADER_INDEX_VICE_NAME]);
        QQmlProperty::write(list, "secretaryName", wordList[HEADER_INDEX_SECRETARY_NAME]);
        QQmlProperty::write(list, "phoneNumber", wordList[HEADER_INDEX_PHONE_NUMBER]);
        QQmlProperty::write(list, "address", wordList[HEADER_INDEX_ADDRESS]);
        QMetaObject::invokeMethod(list, "addToList");
    }
}
