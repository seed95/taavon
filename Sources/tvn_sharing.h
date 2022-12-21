#ifndef TVN_SHARING_H
#define TVN_SHARING_H

#include <QObject>
#include <QString>
#include <QProcess>


class TvnSharing : public QObject
{
    Q_OBJECT
public:
    explicit TvnSharing(QObject *root, QObject *parent = nullptr);

    // src in server side, dst in client(local) side.
    void downlaod(QString srcFilename, QString srcDir, QString dstFilename, QString dstDir);
    void remove(QString srcFilename, QString srcDir);
    // src in client(local) side, dst in server side
    void upload(QString srcFilename, QString srcDir, QString dstFilename, QString dstDir);

    void cancelProcess();

    // Upload src csv (local) file to dst csv (share)
    void uploadCsvFile(QString scrFile, QString dstFile);
    // Download src csv (share) file to dst csv (local)
    void downloadCsvFile(QString srcFile, QString dstFile);

private slots:
    void finishProcess(int code, QProcess::ExitStatus status);
    void errorProcess(QProcess::ProcessError error);

signals:
    void finish();
    void error();

private:
    void logErrorMessage();

private:
    QObject *root;
    QProcess *p;

    QString dst; // contain directory and filename. used for log message
    QString src; // contain directory and filename. used for log message
};

#endif // TVN_SHARING_H
