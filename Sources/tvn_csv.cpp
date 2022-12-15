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
#include <QSaveFile>

TvnCsv::TvnCsv(QObject *root, TvnSharing *sharing, QObject *parent) : QObject(parent)
{
    this->root = root;
    list = root->findChild<QObject*>("ListFile");
    edit = root->findChild<QObject*>("EditFile");

    connect(edit, SIGNAL(saveChanges()), this, SLOT(SaveChanges()));

    // Sharing
    connect(sharing, SIGNAL(finish()), this, SLOT(finishProcess()));
    connect(sharing, SIGNAL(error()), this, SLOT(errorProcess()));
    this->sharing = sharing;
}

bool TvnCsv::SaveImageChanges(QObject *root, bool upload)
{
    QString imageType = TvnUtility::getImageType(root);
    QFile file(conf.localCsvFile);
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
                if (imageType==IMAGE_EXTRAORDINARY_MEETING)
                {
                    wordList[HEADER_INDEX_IMAGE_EXTRAORDINARY_MEETING] = hasImage;
                }
                else if (imageType==IMAGE_GENERAL_MEETING)
                {
                    wordList[HEADER_INDEX_IMAGE_GENERAL_MEETING] = hasImage;
                }
                else if (imageType==IMAGE_LICENCE)
                {
                    wordList[HEADER_INDEX_IMAGE_LICENCE] = hasImage;
                }
                else if (imageType==IMAGE_REGISTRATION_AD)
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
    QFile file(conf.localCsvFile);
    if (!file.open(QIODevice::ReadOnly)) {
        TvnUtility::log(QString("load csv file error (%1), path (%2)")
                        .arg(file.errorString())
                        .arg(conf.localCsvFile));
        TvnUtility::setError(root, ERROR_MESSAGE_LOAD_CSV);
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

        TvnUtility::setFileCode(root,  wordList[HEADER_INDEX_FILE_CODE]);
        TvnUtility::setKeepingPlace(root,  wordList[HEADER_INDEX_KEEPING_PLACE]);
        TvnUtility::setFileStatus(root,  wordList[HEADER_INDEX_STATUS]);
        TvnUtility::setLedgerBinder(root,  wordList[HEADER_INDEX_LEDGER_BINDER]);
        TvnUtility::setNumberOfCover(root,  wordList[HEADER_INDEX_NUMBER_OF_COVER]);
        TvnUtility::setFileName(root,  wordList[HEADER_INDEX_FILE_NAME]);
        TvnUtility::setRegistrationNumber(root,  wordList[HEADER_INDEX_REGISTRATION_NUMBER]);
        TvnUtility::setDateOfRegistration(root,  wordList[HEADER_INDEX_DATE_OF_LAST_MEETING]);
        TvnUtility::setNationalId(root,  wordList[HEADER_INDEX_NATIONAL_ID]);
        TvnUtility::setDateOfLastMeeting(root,  wordList[HEADER_INDEX_DATE_OF_LAST_MEETING]);
        TvnUtility::setNumberOfPrimaryMembers(root,  wordList[HEADER_INDEX_NUMBER_OF_PRIMARY_MEMBERS]);
        TvnUtility::setNumberOfCurrentMembers(root,  wordList[HEADER_INDEX_NUMBER_OF_CURRENT_MEMBERS]);
        TvnUtility::setValuePerShare(root,  wordList[HEADER_INDEX_VALUE_PER_SHARE]);
        TvnUtility::setStartingCapital(root,  wordList[HEADER_INDEX_STARTING_CAPITAL]);
        TvnUtility::setCurrentCapital(root,  wordList[HEADER_INDEX_CURRENT_CAPITAL]);
        TvnUtility::setPhoneNumber(root,  wordList[HEADER_INDEX_PHONE_NUMBER]);
        TvnUtility::setMobileNumber(root,  wordList[HEADER_INDEX_MOBILE_NUMBER]);
        TvnUtility::setOfficeAddress(root,  wordList[HEADER_INDEX_ADDRESS]);
        TvnUtility::setCeoName(root,  wordList[HEADER_INDEX_CEO_NAME]);
        TvnUtility::setChairmanName(root,  wordList[HEADER_INDEX_CHAIRMAN_NAME]);
        TvnUtility::setViceName(root,  wordList[HEADER_INDEX_VICE_NAME]);
        TvnUtility::setSecretaryName(root,  wordList[HEADER_INDEX_SECRETARY_NAME]);
        TvnUtility::setExtraordinaryMeetingHasImage(root,  wordList[HEADER_INDEX_IMAGE_EXTRAORDINARY_MEETING]);
        TvnUtility::setGeneralMeetingHasImage(root,  wordList[HEADER_INDEX_IMAGE_GENERAL_MEETING]);
        TvnUtility::setLicenceHasImage(root,  wordList[HEADER_INDEX_IMAGE_LICENCE]);
        TvnUtility::setRegistrationAdHasImage(root,  wordList[HEADER_INDEX_IMAGE_REGISTRATION_AD]);

        QMetaObject::invokeMethod(list, "addToList");
    }

    file.close();
}

void TvnCsv::SaveChanges()
{
    QFile file(conf.localCsvFile);
    if (!file.open(QIODevice::ReadOnly))
    {
        TvnUtility::log(QString("SaveChanges:: read csv file error (%1)").arg(file.errorString()));
        TvnUtility::setError(edit, ERROR_MESSAGE_SAVE_CHANGES);
        return;
    }

    QTemporaryFile tempFile;
    if (!tempFile.open())
    {
        TvnUtility::log(QString("SaveChanges:: write temp file error (%1)").arg(tempFile.errorString()));
        TvnUtility::setError(edit, ERROR_MESSAGE_SAVE_CHANGES);
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
    QString extraordinaryHasImage = TvnUtility::getExtraordinaryMeetingHasImage(root);
    QString generalHasImage = TvnUtility::getGeneralMeetingHasImage(root);
    QString licenceHasImage = TvnUtility::getLicenceHasImage(root);
    QString registrationHasImage = TvnUtility::getRegistrationAdHasImage(root);

    // Write changes to temp file
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
                wordList[HEADER_INDEX_IMAGE_EXTRAORDINARY_MEETING] = extraordinaryHasImage;
                wordList[HEADER_INDEX_IMAGE_GENERAL_MEETING] = generalHasImage;
                wordList[HEADER_INDEX_IMAGE_LICENCE] = licenceHasImage;
                wordList[HEADER_INDEX_IMAGE_REGISTRATION_AD] = registrationHasImage;
            }
            out << wordList.join(",") << endl;
            continue;
        }

        out << line << endl;
    }

    // Close files
    file.close();
    tempFile.close();


    // Copy temp file to original file

    // Open files
    if (!file.open(QIODevice::WriteOnly))
    {
        TvnUtility::log(QString("SaveChanges:: write csv file error (%1)").arg(file.errorString()));
        TvnUtility::setError(edit, ERROR_MESSAGE_SAVE_CHANGES);
        return;
    }
    if (!tempFile.open())
    {
        TvnUtility::log(QString("SaveChanges:: read temp file error (%1)").arg(tempFile.errorString()));
        TvnUtility::setError(edit, ERROR_MESSAGE_SAVE_CHANGES);
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

    sharing->uploadCsvFile(conf.localCsvFile, conf.shareCsvFile);
}

void TvnCsv::finishProcess()
{
    QString processType = TvnUtility::getProcessType(root);
    if (processType==PROCESS_UPLOAD_CSV)
    {
        QMetaObject::invokeMethod(edit, "saveChangesSuccessfully");
    }
}

void TvnCsv::errorProcess()
{
    QString processType = TvnUtility::getProcessType(root);
    if (processType==PROCESS_UPLOAD_CSV)
    {
        QMetaObject::invokeMethod(edit, "hideDialog");
        TvnUtility::setError(edit, ERROR_MESSAGE_UPLOAD_CSV);
    }
}

