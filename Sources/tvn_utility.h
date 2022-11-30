#ifndef TVN_UTILITY_H
#define TVN_UTILITY_H

#include <QObject>

#define LOG_PATH ".tvn.log"

class TvnUtility : public QObject
{
public:
    static void log(QString message);



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
