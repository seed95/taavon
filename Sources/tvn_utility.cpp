#include "tvn_utility.h"

#include <QFile>
#include <QDebug>
#include <QDateTime>

void TvnUtility::log(QString message)
{
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
