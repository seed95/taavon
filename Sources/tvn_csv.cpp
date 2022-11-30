#include "tvn_csv.h"
#include "tvn_config.h"
#include "tvn_utility.h"
#include "tvn_constant.h"

#include <QFile>
#include <QStringList>
#include <QDebug>
#include <QQmlProperty>
#include <QTemporaryFile>
#include <QTextStream>

TvnCsv::TvnCsv(QObject *root, QObject *parent) : QObject(parent)
{
    this->root = root;
    list = root->findChild<QObject*>("ListFile");

    connect(root, SIGNAL(saveChanges()), this, SLOT(SaveChanges()));
}

bool TvnCsv::SaveImageChanges(QObject *root, int type, bool upload)
{
    QFile file(conf.csvFilePath);
    if (!file.open(QIODevice::ReadOnly))
    {
        TvnUtility::log(QString("SaveImageChanges:: read csv file error (%1)").arg(file.errorString()));
        return false;
    }

    QTemporaryFile tempFile;
    if (!tempFile.open())
    {
        TvnUtility::log(QString("SaveImageChanges:: write temp file error (%1)").arg(tempFile.errorString()));
        return false;
    }
    QTextStream out(&tempFile);

    QString fileCode = TvnUtility::getFileCode(root);
    QString hasImage = QString("%1").arg(upload);

    bool updateChanges = false;
    while (!file.atEnd()) {
        QByteArray line = file.readLine().trimmed();

        if (!updateChanges)
        {
            updateChanges = true;
            QStringList wordList = QString(line).split(",");

            if (wordList.length()!=HEADER_INDEX_TOTAL_NUMBER)
            {
                out << line << endl;
                QString msg = QString("SaveImageChanges:: invalid csv header length, acctual: %1 , desierd: %2)").
                        arg(wordList.length()).arg(HEADER_INDEX_TOTAL_NUMBER);
                continue;
            }

            if (fileCode==wordList[HEADER_INDEX_FILE_CODE])
            {
                if (type==IMAGE_EXTRAORDINARY_MEETING)
                {
                    wordList[HEADER_INDEX_IMAGE_EXTRAORDINARY_MEETING] = hasImage;
                }
                else if (type==IMAGE_GENERAL_MEETING)
                {
                    wordList[HEADER_INDEX_IMAGE_GENERAL_MEETING] = hasImage;
                }
                else if (type==IMAGE_LICENCE)
                {
                    wordList[HEADER_INDEX_IMAGE_LICENCE] = hasImage;
                }
                else if (type==IMAGE_REGISTRATION_AD)
                {
                    wordList[HEADER_INDEX_IMAGE_REGISTRATION_AD] = hasImage;
                }
            }
            out << wordList.join(",") << endl;
            continue;
        }

        out << line << endl;
    }

    // Close files
    file.close();
    tempFile.close();

    // Open files
    if (!file.open(QIODevice::WriteOnly))
    {
        TvnUtility::log(QString("SaveImageChanges:: write csv file error (%1)").arg(file.errorString()));
        return false;
    }
    if (!tempFile.open())
    {
        TvnUtility::log(QString("SaveImageChanges:: read temp file error (%1)").arg(tempFile.errorString()));
        return false;
    }

    // Write in orginal file
    while (!tempFile.atEnd())
    {
        file.write(tempFile.readAll());
    }

    // Close files
    file.close();
    tempFile.close();

    return true;
}

void TvnCsv::LoadCsv()
{
    QFile file(conf.csvFilePath);
    if (!file.open(QIODevice::ReadOnly)) {
        TvnUtility::log(QString("load csv file error (%1)").arg(file.errorString()));
        TvnUtility::setError(root, "امکان باز کردن فایل csv وجود ندارد.");
        return;
    }

    while (!file.atEnd())
    {
        QByteArray line = file.readLine().trimmed();
        QStringList wordList = QString(line).split(",");

        if (wordList.length()!=HEADER_INDEX_TOTAL_NUMBER)
        {
            QString msg = QString("LoadCsv:: invalid csv header length, acctual: %1 , desierd: %2)").
                    arg(wordList.length()).arg(HEADER_INDEX_TOTAL_NUMBER);
            TvnUtility::log(msg);
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
        QQmlProperty::write(list, "extraordinaryMeetingHasImage", wordList[HEADER_INDEX_IMAGE_EXTRAORDINARY_MEETING]);
        QQmlProperty::write(list, "generalMeetingHasImage", wordList[HEADER_INDEX_IMAGE_GENERAL_MEETING]);
        QQmlProperty::write(list, "licenceHasImage", wordList[HEADER_INDEX_IMAGE_LICENCE]);
        QQmlProperty::write(list, "registrationAdHasImage", wordList[HEADER_INDEX_IMAGE_REGISTRATION_AD]);

        QMetaObject::invokeMethod(list, "addToList");
    }

    file.close();
}

void TvnCsv::SaveChanges()
{
    TvnUtility::setError(root, ERROR_MESSAGE_SAVE_CHANGES);
    return;
    QFile file(conf.csvFilePath);
    if (!file.open(QIODevice::ReadOnly))
    {
        TvnUtility::log(QString("SaveChanges:: read csv file error (%1)").arg(file.errorString()));
        TvnUtility::setError(root, ERROR_MESSAGE_SAVE_CHANGES);
        return;
    }

    QTemporaryFile tempFile;
    if (!tempFile.open())
    {
        TvnUtility::log(QString("SaveChanges:: write temp file error (%1)").arg(tempFile.errorString()));
        TvnUtility::setError(root, ERROR_MESSAGE_SAVE_CHANGES);
        return;
    }
    QTextStream out(&tempFile);

    QString fileCode = TvnUtility::getFileCode(root);
    QString keepingPlace = TvnUtility::getKeepingPlace(root);
    QString status = TvnUtility::getFileStatus(root);
    QString ledgerBinder = TvnUtility::getLedgerBinder(root);
    QString numberOfCover = TvnUtility::getNumberOfCover(root);
    QString fileName = TvnUtility::getFileName(root);
    QString registrationNumber = TvnUtility::getRegistrationNumber(root);
    QString dateOfLastMeeting = TvnUtility::getDateOfRegistration(root);
    QString nationalId = TvnUtility::getNationalId(root);
    QString ceoName = TvnUtility::getCeoName(root);
    QString mobileNumber = TvnUtility::getMobileNumber(root);
    QString dateOfRegistration = TvnUtility::getDateOfRegistration(root);
    QString numberOfPrimaryMembers = TvnUtility::getNumberOfPrimaryMembers(root);
    QString numberOfCurrentMembers = TvnUtility::getNumberOfCurrentMembers(root);
    QString valuePerShare = TvnUtility::getValuePerShare(root);
    QString startingCapital = TvnUtility::getStartingCapital(root);
    QString currentCapital = TvnUtility::getCurrentCapital(root);
    QString chairmanName = TvnUtility::getChairmanName(root);
    QString viceName = TvnUtility::getViceName(root);
    QString secretaryName = TvnUtility::getSecretaryName(root);
    QString phoneNumber = TvnUtility::getPhoneNumber(root);
    QString address = TvnUtility::getOfficeAddress(root);

    bool updateChanges = false;
    while (!file.atEnd())
    {
        QByteArray line = file.readLine().trimmed();

        if (!updateChanges)
        {
            updateChanges = true;
            QStringList wordList = QString(line).split(",");

            if (wordList.length()!=HEADER_INDEX_TOTAL_NUMBER)
            {
                out << line << endl;
                QString msg = QString("SaveChanges:: invalid csv header length, acctual: %1 , desierd: %2)").
                        arg(wordList.length()).arg(HEADER_INDEX_TOTAL_NUMBER);
                TvnUtility::log(msg);
                continue;
            }

            if (fileCode==wordList[HEADER_INDEX_FILE_CODE])
            {
                wordList[HEADER_INDEX_KEEPING_PLACE] = keepingPlace;
                wordList[HEADER_INDEX_STATUS] = status;
                wordList[HEADER_INDEX_LEDGER_BINDER] = ledgerBinder;
                wordList[HEADER_INDEX_NUMBER_OF_COVER] = numberOfCover;
                wordList[HEADER_INDEX_FILE_NAME] = fileName;
                wordList[HEADER_INDEX_REGISTRATION_NUMBER] = registrationNumber;
                wordList[HEADER_INDEX_DATE_OF_LAST_MEETING] = dateOfLastMeeting;
                wordList[HEADER_INDEX_NATIONAL_ID] = nationalId;
                wordList[HEADER_INDEX_CEO_NAME] = ceoName;
                wordList[HEADER_INDEX_MOBILE_NUMBER] = mobileNumber;
                wordList[HEADER_INDEX_DATE_OF_REGISTRATION] = dateOfRegistration;
                wordList[HEADER_INDEX_NUMBER_OF_PRIMARY_MEMBERS] = numberOfPrimaryMembers;
                wordList[HEADER_INDEX_NUMBER_OF_CURRENT_MEMBERS] = numberOfCurrentMembers;
                wordList[HEADER_INDEX_VALUE_PER_SHARE] = valuePerShare;
                wordList[HEADER_INDEX_STARTING_CAPITAL] = startingCapital;
                wordList[HEADER_INDEX_CURRENT_CAPITAL] = currentCapital;
                wordList[HEADER_INDEX_CHAIRMAN_NAME] = chairmanName;
                wordList[HEADER_INDEX_VICE_NAME] = viceName;
                wordList[HEADER_INDEX_SECRETARY_NAME] = secretaryName;
                wordList[HEADER_INDEX_PHONE_NUMBER] = phoneNumber;
                wordList[HEADER_INDEX_ADDRESS] = address;
            }
            out << wordList.join(",") << endl;
            continue;
        }

        out << line << endl;
    }

    // Close files
    file.close();
    tempFile.close();

    // Open files
    if (!file.open(QIODevice::WriteOnly))
    {
        TvnUtility::log(QString("SaveChanges:: write csv file error (%1)").arg(file.errorString()));
        TvnUtility::setError(root, ERROR_MESSAGE_SAVE_CHANGES);
        return;
    }
    if (!tempFile.open())
    {
        TvnUtility::log(QString("SaveChanges:: read temp file error (%1)").arg(tempFile.errorString()));
        TvnUtility::setError(root, ERROR_MESSAGE_SAVE_CHANGES);
        return;
    }

    // Write in orginal file
    while (!tempFile.atEnd())
    {
        file.write(tempFile.readAll());
    }

    // Close files
    file.close();
    tempFile.close();

    QMetaObject::invokeMethod(root, "saveChangesSuccessfully");
}

