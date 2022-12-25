#include <QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>

#include "tvn_csv.h"
#include "tvn_config.h"
#include "tvn_image.h"
#include "tvn_utility.h"
#ifdef Q_OS_WIN
#include "dll_generator.h"
#endif

// .\windeployqt --qmldir C:\Users\seed\Desktop\taavon\Qml C:\Users\seed\Desktop\taavon\release

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);
    app.setOrganizationName("SEED");
    app.setOrganizationDomain("seed.com");
//    app.setApplicationName("Cooperative Files Management");

#ifdef Q_OS_WIN
    GenerateDll();
#endif

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    engine.load(url);
    QObject *mainItem = engine.rootObjects().first();

    TvnConfig *config = new TvnConfig(mainItem);
    TvnUtility::setIsEditbale(mainItem, conf.editable);

    TvnSharing *sharing = new TvnSharing(mainItem);
    TvnCsv *csv = new TvnCsv(mainItem, sharing);
    csv->DownloadCsv();
    TvnImage *imageHandler = new TvnImage(mainItem, sharing);

    return app.exec();
}
