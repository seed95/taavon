#include "tvn_utility.h"

#include <QFile>
#include <QDebug>
#include <QDateTime>
#include <QQmlProperty>

void TvnUtility::log(QString message)
{
    qDebug() << "log" << message;
    // TODO handle large log fie into multi file whe volume is too large
    QLocale en_localce(QLocale::English);
    QString date = en_localce.toString(QDateTime::currentDateTime(), "MM/dd hh:mm:ss ---> ");
    QFile log_file(LOG_PATH);
    if( log_file.open(QIODevice::Append) )
    {
        QTextStream out(&log_file);
        out << date << message << "\n";
        log_file.close();
    }
    else
    {
        qDebug() << "Cannot open" << log_file.fileName();
    }
}

void TvnUtility::setError(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "errorMessage", data);
}

void TvnUtility::setFileCode(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "fileCode", data);
}

void TvnUtility::setKeepingPlace(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "keepingPlace", data);
}

void TvnUtility::setFileStatus(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "fileStatus", data);
}

void TvnUtility::setLedgerBinder(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "ledgerBinder", data);
}

void TvnUtility::setNumberOfCover(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "numberOfCover", data);
}

void TvnUtility::setFileName(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "fileName", data);
}

void TvnUtility::setRegistrationNumber(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "registrationNumber", data);
}

void TvnUtility::setDateOfRegistration(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "dateOfRegistration", data);
}

void TvnUtility::setNationalId(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "nationalId", data);
}

void TvnUtility::setDateOfLastMeeting(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "dateOfLastMeeting", data);
}

void TvnUtility::setNumberOfPrimaryMembers(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "numberOfPrimaryMembers", data);
}

void TvnUtility::setNumberOfCurrentMembers(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "numberOfCurrentMembers", data);
}

void TvnUtility::setValuePerShare(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "valuePerShare", data);
}

void TvnUtility::setStartingCapital(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "startingCapital", data);
}

void TvnUtility::setCurrentCapital(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "currentCapital", data);
}

void TvnUtility::setPhoneNumber(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "phoneNumber", data);
}

void TvnUtility::setMobileNumber(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "mobileNumber", data);
}

void TvnUtility::setOfficeAddress(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "officeAddress", data);
}

void TvnUtility::setCeoName(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "ceoName", data);
}

void TvnUtility::setChairmanName(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "chairmanName", data);
}

void TvnUtility::setViceName(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "viceName", data);
}

void TvnUtility::setSecretaryName(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "secretaryName", data);
}

void TvnUtility::setExtraordinaryMeetingHasImage(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "extraordinaryMeetingHasImage", data);
}

void TvnUtility::setGeneralMeetingHasImage(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "generalMeetingHasImage", data);
}

void TvnUtility::setLicenceHasImage(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "licenceHasImage", data);
}

void TvnUtility::setRegistrationAdHasImage(QObject *ui, QString data)
{
    QQmlProperty::write(ui, "registrationAdHasImage", data);
}


QString TvnUtility::getFileCode(QObject *ui)
{
    return getQmlProperty(ui, "fileCode");
}

QString TvnUtility::getKeepingPlace(QObject *ui)
{
    return getQmlProperty(ui, "keepingPlace");
}

QString TvnUtility::getFileStatus(QObject *ui)
{
    return getQmlProperty(ui, "fileStatus");
}

QString TvnUtility::getLedgerBinder(QObject *ui)
{
    return getQmlProperty(ui, "ledgerBinder");
}

QString TvnUtility::getNumberOfCover(QObject *ui)
{
    return getQmlProperty(ui, "numberOfCover");
}

QString TvnUtility::getFileName(QObject *ui)
{
    return getQmlProperty(ui, "fileName");
}

QString TvnUtility::getRegistrationNumber(QObject *ui)
{
    return getQmlProperty(ui, "registrationNumber");
}

QString TvnUtility::getDateOfRegistration(QObject *ui)
{
    return getQmlProperty(ui, "dateOfRegistration");
}

QString TvnUtility::getNationalId(QObject *ui)
{
    return getQmlProperty(ui, "nationalId");
}

QString TvnUtility::getDateOfLastMeeting(QObject *ui)
{
    return getQmlProperty(ui, "dateOfLastMeeting");
}

QString TvnUtility::getNumberOfPrimaryMembers(QObject *ui)
{
    return getQmlProperty(ui, "numberOfPrimaryMembers");
}

QString TvnUtility::getNumberOfCurrentMembers(QObject *ui)
{
    return getQmlProperty(ui, "numberOfCurrentMembers");
}

QString TvnUtility::getValuePerShare(QObject *ui)
{
    return getQmlProperty(ui, "valuePerShare");
}

QString TvnUtility::getStartingCapital(QObject *ui)
{
    return getQmlProperty(ui, "startingCapital");
}

QString TvnUtility::getCurrentCapital(QObject *ui)
{
    return getQmlProperty(ui, "currentCapital");
}

QString TvnUtility::getPhoneNumber(QObject *ui)
{
    return getQmlProperty(ui, "phoneNumber");
}

QString TvnUtility::getMobileNumber(QObject *ui)
{
    return getQmlProperty(ui, "mobileNumber");
}

QString TvnUtility::getOfficeAddress(QObject *ui)
{
    return getQmlProperty(ui, "officeAddress");
}

QString TvnUtility::getCeoName(QObject *ui)
{
    return getQmlProperty(ui, "ceoName");
}

QString TvnUtility::getChairmanName(QObject *ui)
{
    return getQmlProperty(ui, "chairmanName");
}

QString TvnUtility::getViceName(QObject *ui)
{
    return getQmlProperty(ui, "viceName");
}

QString TvnUtility::getSecretaryName(QObject *ui)
{
    return getQmlProperty(ui, "secretaryName");
}

QString TvnUtility::getExtraordinaryMeetingHasImage(QObject *ui)
{
    return getQmlProperty(ui, "extraordinaryMeetingHasImage");
}

QString TvnUtility::getGeneralMeetingHasImage(QObject *ui)
{
    return getQmlProperty(ui, "generalMeetingHasImage");
}

QString TvnUtility::getLicenceHasImage(QObject *ui)
{
    return getQmlProperty(ui, "licenceHasImage");
}

QString TvnUtility::getRegistrationAdHasImage(QObject *ui)
{
    return getQmlProperty(ui, "registrationAdHasImage");
}


QString TvnUtility::getProcessType(QObject *ui)
{
    return getQmlProperty(ui, "processType");
}

QString TvnUtility::getImageType(QObject *ui)
{
    return getQmlProperty(ui, "imageType");
}


QString TvnUtility::getExtraordinaryPath(QObject *ui)
{
    return getQmlProperty(ui, "extraordinaryPath");
}

QString TvnUtility::getGeneralPath(QObject *ui)
{
    return getQmlProperty(ui, "generalPath");
}

QString TvnUtility::getLicencePath(QObject *ui)
{
    return getQmlProperty(ui, "licencePath");
}

QString TvnUtility::getRegistrationPath(QObject *ui)
{
    return getQmlProperty(ui, "registrationPath");
}


QString TvnUtility::getExtraordinaryDeleted(QObject *ui)
{
    return getQmlProperty(ui, "extraordinaryDeleted");
}

QString TvnUtility::getGeneralDeleted(QObject *ui)
{
    return getQmlProperty(ui, "generalDeleted");
}

QString TvnUtility::getLicenceDeleted(QObject *ui)
{
    return getQmlProperty(ui, "licenceDeleted");
}

QString TvnUtility::getRegistrationDeleted(QObject *ui)
{
    return getQmlProperty(ui, "registrationDeleted");
}


QString TvnUtility::getQmlProperty(QObject *ui, QString key)
{
    QVariant data = QQmlProperty::read(ui, key);
    if( data.isValid() )
    {
        return data.toString();
    }
    log(QString("invalid qml property %1").arg(key));
    return "";
}

