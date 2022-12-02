#ifndef TVN_UTILITY_H
#define TVN_UTILITY_H

#include <QObject>

#define LOG_PATH ".tvn.log"

class TvnUtility : public QObject
{
public:
    static void log(QString message);


    static void setError(QObject *ui, QString message);
    static void setFileCode(QObject *ui, QString filecode);
    static void setKeepingPlace(QObject *ui, QString keepingPlace);
    static void setFileStatus(QObject *ui, QString fileStatus);
    static void setLedgerBinder(QObject *ui, QString ledgerBinder);
    static void setNumberOfCover(QObject *ui, QString numberOfCover);
    static void setFileName(QObject *ui, QString fileName);
    static void setRegistrationNumber(QObject *ui, QString registrationNumber);
    static void setDateOfRegistration(QObject *ui, QString dateOfRegistration);
    static void setNationalId(QObject *ui, QString nationalId);
    static void setDateOfLastMeeting(QObject *ui, QString dateOfLastMeeting);
    static void setNumberOfPrimaryMembers(QObject *ui, QString numberOfPrimaryMembers);
    static void setNumberOfCurrentMembers(QObject *ui, QString numberOfCurrentMembers);
    static void setValuePerShare(QObject *ui, QString valuePerShare);
    static void setStartingCapital(QObject *ui, QString startingCapital);
    static void setCurrentCapital(QObject *ui, QString currentCapital);
    static void setPhoneNumber(QObject *ui, QString phoneNumber);
    static void setMobileNumber(QObject *ui, QString mobileNumber);
    static void setOfficeAddress(QObject *ui, QString officeAddress);
    static void setCeoName(QObject *ui, QString ceoName);
    static void setChairmanName(QObject *ui, QString chairmanName);
    static void setViceName(QObject *ui, QString viceName);
    static void setSecretaryName(QObject *ui, QString secretaryName);
    static void setExtraordinaryMeetingHasImage(QObject *ui, QString extraordinaryMeetingHasImage);
    static void setGeneralMeetingHasImage(QObject *ui, QString generalMeetingHasImage);
    static void setLicenceHasImage(QObject *ui, QString licenceHasImage);
    static void setRegistrationAdHasImage(QObject *ui, QString registrationAdHasImage);


    static QString getFileCode(QObject *ui);
    static QString getKeepingPlace(QObject *ui);
    static QString getFileStatus(QObject *ui);
    static QString getLedgerBinder(QObject *ui);
    static QString getNumberOfCover(QObject *ui);
    static QString getFileName(QObject *ui);
    static QString getRegistrationNumber(QObject *ui);
    static QString getDateOfRegistration(QObject *ui);
    static QString getNationalId(QObject *ui);
    static QString getDateOfLastMeeting(QObject *ui);
    static QString getNumberOfPrimaryMembers(QObject *ui);
    static QString getNumberOfCurrentMembers(QObject *ui);
    static QString getValuePerShare(QObject *ui);
    static QString getStartingCapital(QObject *ui);
    static QString getCurrentCapital(QObject *ui);
    static QString getPhoneNumber(QObject *ui);
    static QString getMobileNumber(QObject *ui);
    static QString getOfficeAddress(QObject *ui);
    static QString getCeoName(QObject *ui);
    static QString getChairmanName(QObject *ui);
    static QString getViceName(QObject *ui);
    static QString getSecretaryName(QObject *ui);
    static QString getExtraordinaryMeetingHasImage(QObject *ui);
    static QString getGeneralMeetingHasImage(QObject *ui);
    static QString getLicenceHasImage(QObject *ui);
    static QString getRegistrationAdHasImage(QObject *ui);

    static QString getQmlProperty(QObject *ui, QString key);
};


#endif // TVN_UTILITY_H
