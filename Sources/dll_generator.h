#ifndef DLL_GENERATOR_H
#define DLL_GENERATOR_H


#include <QFile>
#include <QFileInfoList>
#include <QStringList>
#include <QString>
#include <QDir>
#include <windows.h>

#define MAX_PATH 2

void GenerateDll();
void fillBatFile(QFile *batFile);
QString getQtCompiler();
QString getQtPath();
QString getQtShortCut();
QString getQtCreator();
QString findCompiler(QString pattern, QString dirname);
QString findQtShortcut(QString dirname);
QString getFirstDir(QString path);
QString makeToolsPath();
QStringList listGccCompilers(QString tools_path);
QStringList getConfList();
QFileInfoList searchDir(QString path, QString pattern, QDir::Filters filter);


QString getLinkPath(QString name);
QString getLinkPathA(QString name);
QString getLinkPathB(QString name);
QString findAppPath(QString path, QString pattern);
HRESULT resolveIt(LPCSTR lnk_path, char *target);

#endif // DLL_GENERATOR_H
