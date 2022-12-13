#include "tvn_sharing.h"
#include "tvn_utility.h"
#include "tvn_constant.h"
#include "tvn_config.h"

#include <QDebug>
#include <QDateTime>


TvnSharing::TvnSharing(QObject *root, QObject *parent) : QObject(parent)
{
    this->root = root;
    p = new QProcess();
    QObject::connect(p, SIGNAL(finished(int, QProcess::ExitStatus)),
                     this, SLOT(finishProcess(int, QProcess::ExitStatus)));
    QObject::connect(p, SIGNAL(error(QProcess::ProcessError)),
                     this, SLOT(errorProcess(QProcess::ProcessError)));

    // Save smbclient log
    p->setStandardOutputFile(".smb.log", QProcess::Append);
    p->setStandardErrorFile(".smb.log", QProcess::Append);
}

//TODO check for windows
void TvnSharing::downlaod(QString srcFilename, QString srcDir, QString dstFilename, QString dstDir)
{
    // Check another process is runnig
    QString processType = TvnUtility::getProcessType(root);
    if (processType!=PROCESS_IMAGE_DOWNLOAD)
    {
        emit error();
        return;
    }

    // Save destination and source for log message
    dst = dstDir + dstFilename;
    src = srcDir + srcFilename;

    QString smbCommand = "lcd \"" + dstDir + "\"; cd " + srcDir + "; get " + srcFilename + " \"" + dstFilename + "\";";
    QStringList args;
    args <<  conf.shareFolder << "-c" << smbCommand << "-U=seed%ever";
    p->start("smbclient", args);
}

//TODO check for windows
void TvnSharing::upload(QString srcFilename, QString srcDir, QString dstFilename, QString dstDir)
{
    // Check another process is runnig
    QString processType = TvnUtility::getProcessType(root);
    if (processType!=PROCESS_IMAGE_UPLOAD)
    {
        emit error();
        return;
    }

    // Save destination and source for log message
    dst = dstDir + "/" + dstFilename;
    src = srcDir + "/" + srcFilename;

    // TODO check image exist is needed?

    QString smbCommand = "lcd \"" + srcDir + "\"; mkdir " + dstDir + "; cd " + dstDir +
            "; put \"" + srcFilename + "\" " + dstFilename + ";";
    QStringList args;
    args << conf.shareFolder << "-c" << smbCommand << "-U=seed%ever";
    p->start("smbclient", args);
}

//TODO check for windows
void TvnSharing::remove(QString srcFilename, QString srcDir)
{
    // Check another process is runnig
    QString processType = TvnUtility::getProcessType(root);
    if (processType!=PROCESS_IMAGE_REMOVE)
    {
        emit error();
        return;
    }

    // Make destination path
    QString dstDir = srcDir + "/delete";
    QLocale en_localce(QLocale::English);
    QString date = en_localce.toString(QDateTime::currentDateTime(), "yyyyMMdd-hhmmss-");
    QString dstFilename = "delete/" + date + srcFilename;

    dst = srcDir + "/" + dstFilename;
    src = srcDir + "/" + srcFilename;

    QString smbCommand = "mkdir " + dstDir + "; cd " + srcDir +
            "; scopy " + srcFilename + " " + dstFilename + "; rm " + srcFilename + ";";
    QStringList args;
    args <<  conf.shareFolder << "-c" << smbCommand << "-U=seed%ever";
    p->start("smbclient", args);

}

//TODO check for windows
void TvnSharing::uploadCsvFile(QString scrFile, QString dstFile)
{
    // Check another process is runnig
    QString processType = TvnUtility::getProcessType(root);
    if (processType!=PROCESS_UPLOAD_CSV)
    {
        emit error();
        return;
    }

    // Save destination and source for log message
    dst = dstFile;
    src = scrFile;

    QString smbCommand = "put \"" + scrFile + "\" " + dstFile + ";";
    QStringList args;
    args << conf.shareFolder << "-c" << smbCommand << "-U=seed%ever";
    p->start("smbclient", args);
}

void TvnSharing::cancelProcess()
{
    p->kill();
}

void TvnSharing::finishProcess(int code, QProcess::ExitStatus status)
{
    qDebug() << "finish process" << ", code: " << code << ", status: " << status;

    // when manually kill the process, process is crashed.
    if (status==QProcess::CrashExit)
    {
        return;
    }

    if (code!=0) // error happened
    {
        logErrorMessage();
        emit error();
        return;
    }
    emit finish();
}

void TvnSharing::errorProcess(QProcess::ProcessError errorCode)
{
    qDebug() << "error process, code: " << errorCode;
    // if manually kill the process, the process is crashed
    if (errorCode==QProcess::Crashed)
    {
        return;
    }
    logErrorMessage();
    emit error();
}

void TvnSharing::logErrorMessage()
{
    QString processType = TvnUtility::getProcessType(root);
    QString msg = "";
    if (processType==PROCESS_IMAGE_DOWNLOAD)
    {
        msg = QString("copy failed <local dest: %1, share src: %2>").arg(dst).arg(src);
    }
    else if (processType==PROCESS_IMAGE_UPLOAD)
    {
        msg = QString("upload failed <share dest: %1, local src: %2>").arg(dst).arg(src);
    }
    else if (processType==PROCESS_IMAGE_REMOVE)
    {
        msg = QString("remove failed <share dest: %1, share src: %2>").arg(dst).arg(src);
    }
    else if (processType==PROCESS_UPLOAD_CSV)
    {
        msg = QString("upload csv failed <share dest: %1, local src: %2>").arg(dst).arg(src);
    }

    TvnUtility::log("errorProcess:: " + processType + " failed, message: " + msg);
}
