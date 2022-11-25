#ifndef TVN_UTILITY_H
#define TVN_UTILITY_H

#include <QObject>

#define LOG_PATH ".tvn.log"

class TvnUtility : public QObject
{
public:
    static void log(QString message);
};


#endif // TVN_UTILITY_H
