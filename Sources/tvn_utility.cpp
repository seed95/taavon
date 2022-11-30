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


QString TvnUtility::getQmlProperty(QObject *ui, QString key)
{
    QVariant data = QQmlProperty::read(ui, key);
    if( data.isValid() )
    {
        return data.toString();
    }
    // TODO handle this
    return "";
}

