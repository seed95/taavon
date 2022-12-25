#include "dll_generator.h"
#include <QDebug>
//#include <shobjidl.h>
//#include <shlguid.h>

void GenerateDll()
{
    QString projectPath = QDir::currentPath();
    QDir directory(projectPath);
    QStringList dllFiles = directory.entryList(QStringList() << "*.dll", QDir::Files);
    if( dllFiles.size()>0 )
    {
        // DLLs are already generated
        return;
    }

    projectPath += "/dll_gen.bat";
    projectPath.replace("/", "\\");
    QFile *batFile = new QFile(projectPath);
    if( !batFile->open(QIODevice::WriteOnly |
                        QIODevice::Text) )
    {
        qDebug() << "Error: cannot open dll_gen file" << batFile;
        return;
    }
    fillBatFile(batFile);
    batFile->close();
//    qDebug() << "ending" << project_path;
}

void fillBatFile(QFile *batFile)
{
    QString qtCompilerPath = getQtCompiler();
    if( qtCompilerPath.isEmpty() )
    {
        return;
    }
    batFile->write("set PATH=%PATH%;");
    batFile->write(qtCompilerPath.toStdString().c_str());
    batFile->write("\nwindeployqt ");
    QString binPath = QDir::currentPath();
    binPath.replace("/", "\\");
//    bat_file->write(project_path.toStdString().c_str());
//    bat_file->write("\\Sources ");
    batFile->write(binPath.toStdString().c_str());

    QString toolsPath = makeToolsPath();
    if( toolsPath.isEmpty() )
    {
        qDebug() << "Error: Cannot retreive "
                    "cp path from compiler path";
        return;
    }
    QStringList libs;
    libs << "libstdc++-6.dll" << "libwinpthread-1.dll";
    libs += listGccCompilers(toolsPath);
    for( int i=0 ; i<libs.size() ; i++ )
    {
        batFile->write("\ncopy \"");
        batFile->write(toolsPath.toStdString().c_str());
        batFile->write(libs[i].toStdString().c_str());
        batFile->write("\" ");
        batFile->write(binPath.toStdString().c_str());
    }
}

QString getQtCompiler()
{
    // C:\Qt\Qt5.7.0
    QString qtCompiler = getQtPath();
    if( qtCompiler.isEmpty() )
    {
        return "";
    }
    // 5.7.0
    QString qt_dir = getFirstDir(qtCompiler);
    if( qt_dir.isEmpty() )
    {
        return "";
    }
    // C:\Qt\Qt5.7.0\5.7.0
    qtCompiler += "\\" + qt_dir;
    // mingw53_32
    QString compiler = findCompiler("mingw", qtCompiler);
    if( compiler.isEmpty() )
    {
        return "";
    }
    // C:\Qt\Qt5.7.0\5.7.0\mingw53_32\bin
    qtCompiler += "\\" + compiler + "\\bin";
    return qtCompiler;
}

QString makeToolsPath()
{
    QString creatorPath = getQtCreator();
    if( creatorPath.isEmpty() )
    {
        return "";
    }
    // D:\Qt\Qt5.13.1\Tools\QtCreator\bin\qtcreator.exe
    int index = creatorPath.lastIndexOf("\\");
    QString libPath = creatorPath.mid(0, index);
    // D:\Qt\Qt5.13.1\Tools\QtCreator\bin
    index = libPath.lastIndexOf("\\");
    libPath = libPath.mid(0, index);
    // D:\Qt\Qt5.13.1\Tools\QtCreator
    index = libPath.lastIndexOf("\\");
    libPath = libPath.mid(0, index);
    // D:\Qt\Qt5.13.1\Tools
    QString compiler = findCompiler("mingw", libPath);
    if( compiler.isEmpty() )
    {
        return "";
    }
    libPath += "\\" + compiler + "\\bin\\";
    return libPath;
}

QString getQtPath()
{
    QString creatorPath = getQtCreator();
    if( creatorPath.isEmpty() )
    {
        return "";
    }
    // 3-level parent dir
    // D:\Qt\Qt5.13.1\Tools\QtCreator\bin\qtcreator.exe
    int index = creatorPath.lastIndexOf("\\");
    QString qtPath = creatorPath.mid(0, index);
    // D:\Qt\Qt5.13.1\Tools\QtCreator\bin
    index = qtPath.lastIndexOf("\\");
    qtPath = qtPath.mid(0, index);
    // D:\Qt\Qt5.13.1\Tools\QtCreator
    index = qtPath.lastIndexOf("\\");
    qtPath = qtPath.mid(0, index);
    // D:\Qt\Qt5.13.1\Tools
    index = qtPath.lastIndexOf("\\");
    qtPath = qtPath.mid(0, index);
    // D:\Qt\Qt5.13.1

    return qtPath;
}

QString getQtShortCut()
{
    QString startMenu = getenv("APPDATA");
    startMenu += "\\Microsoft\\Windows\\Start Menu\\Programs\\";
    QString qtShortcut = findQtShortcut(startMenu);
    if( qtShortcut.isEmpty() )
    {
        startMenu = getenv("PROGRAMDATA");
        startMenu += "\\Microsoft\\Windows\\Start Menu\\Programs\\";
        qtShortcut = findQtShortcut(startMenu);
    }

    return qtShortcut;
}

QString findQtShortcut(QString dirname)
{
    QDir menuDir(dirname);
    QRegExp QtReg("^Qt");
    menuDir.setFilter(QDir::Dirs | QDir::NoSymLinks |
                       QDir::NoDot | QDir::NoDotDot);

    QFileInfoList dirList = menuDir.entryInfoList();
    for( int i=0 ; i<dirList.size() ; i++ )
    {
        if( dirList[i].fileName().contains(QtReg) )
        {
            QDir qtDir(dirname + "\\" + dirList[i].fileName());
            QRegExp creatorReg("^Qt Creator");
            QFileInfoList qtDirList = qtDir.entryInfoList();
            for( int j=0 ; j<qtDirList.size() ; j++ )
            {
                if( qtDirList[j].fileName().contains(creatorReg) )
                {
                    QString ret = dirList[i].fileName() + "\\" +
                                  qtDirList[j].completeBaseName();
                    return ret;
                }
            }
        }
    }
    return "";
}

QString getQtCreator()
{
    QString shortcutName = "qt";
    QString link_path = getLinkPath(shortcutName);
    if( link_path=="" )
    {
        qDebug() << "Error: get link path failed"
                 << shortcutName;
        return "";
    }
    char buffer[200];
    GetLongPathNameA(link_path.toStdString().c_str(), buffer, 200);
    return buffer;
}

QStringList listGccCompilers(QString toolsPath)
{
    QStringList compilers;
    QFileInfoList fileList = searchDir(toolsPath, "^libgcc_",
                                   QDir::Files | QDir::NoSymLinks |
                                   QDir::NoDot | QDir::NoDotDot);

    for( int i=0 ; i<fileList.size() ; i++ )
    {
        compilers.push_back(fileList[i].fileName());
    }
    return compilers;
}

QString findCompiler(QString pattern, QString dirname)
{
    QDir dir(dirname);
    dir.setFilter(QDir::Dirs | QDir::NoSymLinks |
                  QDir::NoDot | QDir::NoDotDot);

    QString reg_exp;
#ifdef Q_PROCESSOR_X86_64
    reg_exp = "64$";
#else
    reg_exp = "32$";
#endif

    QRegExp ver_reg(reg_exp);

    QFileInfoList fileList = dir.entryInfoList();
    for( int i=0 ; i<fileList.size() ; i++ )
    {
        QFileInfo fileInfo = fileList[i];
        if( fileInfo.fileName().contains(pattern) &&
            fileInfo.fileName().contains(ver_reg) )
        {
            return fileInfo.fileName();
        }
    }
    return "";
}

QString getFirstDir(QString path)
{
    QDir menuDir(path);
    menuDir.setFilter(QDir::Dirs | QDir::NoSymLinks |
                       QDir::NoDot | QDir::NoDotDot);
    QFileInfoList dirList = menuDir.entryInfoList();
    return dirList[0].fileName();
}

QStringList getConfList()
{
    QStringList ret;

    QString projectPath = QDir::currentPath();
    // D:\Work\bijan\AccJoon\release
    projectPath.replace("/", "\\");
    projectPath += "\\Conf";
    // D:\Work\bijan\AccJoon\conf

    QFileInfoList confList = searchDir(projectPath, ".acc$",
                 QDir::Files | QDir::NoSymLinks |
                 QDir::NoDot | QDir::NoDotDot);
    for( int i=0; i<confList.size(); i++ )
    {
        ret.push_back(confList[i].absoluteFilePath().replace("/", "\\"));
    }
    return ret;
}

QFileInfoList searchDir(QString path, QString pattern,
                           QDir::Filters filter)
{
    QFileInfoList ret;
    QDir directory(path);
    QRegExp QtReg(pattern);
    directory.setFilter(filter);

    if( directory.exists() )
    {
        QFileInfoList fileList = directory.entryInfoList();

        for( int i=0 ; i<fileList.size() ; i++ )
        {
            if( fileList[i].fileName().contains(QtReg) )
            {
                ret.push_back(fileList[i]);
            }
        }
    }
    else
    {
        qDebug() << "Error: Directory doesnt exist.";
    }
    return ret;
}



QString getLinkPath(QString name)
{
    QString ret = getLinkPathA(name);
    if( ret.isEmpty() )
    {
        ret = getLinkPathB(name);
    }
    return ret;
}

QString getLinkPathA(QString name)
{
    char target[MAX_PATH];

    QString lnk = getenv("APPDATA");
    lnk += "\\Microsoft\\Windows\\Start Menu\\Programs\\";
    lnk = findAppPath(lnk, name);

    resolveIt(lnk.toStdString().c_str(), target);

    return target;
}

//retreive link from ProgramData instead of user account
QString getLinkPathB(QString name)
{
    char target[MAX_PATH];

    QString lnk = getenv("PROGRAMDATA");
    lnk += "\\Microsoft\\Windows\\Start Menu\\Programs\\";
    lnk = findAppPath(lnk, name);

    resolveIt(lnk.toStdString().c_str(), target);

    return target;
}

QString findAppPath(QString path, QString pattern)
{
    QDir directory(path);
    directory.setFilter(QDir::Files | QDir::NoDot | QDir::NoDotDot);
    QRegExp pattern_reg("^" + pattern.toLower());
    QRegExp lnk_reg(".lnk$");

    if( directory.exists() )
    {
        QFileInfoList file_list = directory.entryInfoList();

        for( int i=0 ; i<file_list.size() ; i++ )
        {
            if( file_list[i].fileName().toLower().contains(pattern_reg) &&
                file_list[i].fileName().contains(lnk_reg))
            {
                return file_list[i].absoluteFilePath().replace("/", "\\");
            }
        }
        directory.setFilter(QDir::Dirs | QDir::NoSymLinks |
                            QDir::NoDot | QDir::NoDotDot);

        QFileInfoList dir_list = directory.entryInfoList();

        for( int i=0 ; i<dir_list.size() ; i++ )
        {
            if( dir_list[i].fileName().toLower().contains(pattern_reg) )
            {
                return findAppPath(dir_list[i].absoluteFilePath()
                                   .replace("/", "\\"),  pattern);
            }
        }
        return "";
    }
    else
    {
        qDebug() << "Error: Directory doesnt exist.";
        return "";
    }
}

HRESULT resolveIt(LPCSTR lnk_path, char *target)
{
    HRESULT hres;
    IShellLink* psl;
    WCHAR szGotPath[MAX_PATH];
    WCHAR szDescription[MAX_PATH];
    WIN32_FIND_DATA wfd;

    *target = 0; // Assume failure

    // Get a pointer to the IShellLink interface. It is assumed that CoInitialize
    // has already been called.
    hres = CoCreateInstance(CLSID_ShellLink, NULL, CLSCTX_INPROC_SERVER, IID_IShellLink, (LPVOID*)&psl);
    if( SUCCEEDED(hres) )
    {
        IPersistFile* ppf;

        // Get a pointer to the IPersistFile interface.
        hres = psl->QueryInterface(IID_IPersistFile, (void**)&ppf);

        if (SUCCEEDED(hres))
        {
            WCHAR wsz[MAX_PATH];

            // Ensure that the string is Unicode.
            MultiByteToWideChar(CP_ACP, 0, lnk_path, -1, wsz, MAX_PATH);

            // Add code here to check return value from MultiByteWideChar
            // for success.

            // Load the shortcut.
            hres = ppf->Load(wsz, STGM_READ);

            if (SUCCEEDED(hres))
            {
                // Resolve the link.
                HWND hwnd = GetActiveWindow();
                hres = psl->Resolve(hwnd, 0);

                if (SUCCEEDED(hres))
                {
                    // Get the path to the link target.
                    hres = psl->GetPath(szGotPath, MAX_PATH, (WIN32_FIND_DATA*)&wfd, SLGP_SHORTPATH);

                    if (SUCCEEDED(hres))
                    {
                        // Get the description of the target.
                        hres = psl->GetDescription(szDescription, MAX_PATH);

                        if (SUCCEEDED(hres))
                        {
                            hres = wcstombs(target, szGotPath, wcslen(szGotPath) + 1);
                            if (SUCCEEDED(hres))
                            {
                                // Handle success
                            }
                            else
                            {
                                // Handle the error
                            }
                        }
                    }
                }
            }

            // Release the pointer to the IPersistFile interface.
            ppf->Release();
        }

        // Release the pointer to the IShellLink interface.
        psl->Release();
    }
    return hres;
}
