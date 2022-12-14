#include <QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>

#include "tvn_csv.h"
#include "tvn_config.h"
#include "tvn_image.h"
#include "tvn_utility.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);
    app.setOrganizationName("SEED");
    app.setOrganizationDomain("seed.com");
//    app.setApplicationName("Cooperative Files Management");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    engine.load(url);
    QObject *mainItem = engine.rootObjects().first();

    TvnConfig *config = new TvnConfig();
    TvnUtility::setIsEditbale(mainItem, conf.editable);

    TvnSharing *sharing = new TvnSharing(mainItem);

    TvnCsv *csv = new TvnCsv(mainItem, sharing);
    csv->LoadCsv();

    TvnImage *imageHandler = new TvnImage(mainItem, sharing);

//    hhm_log("-------------------------Start Document Manager-------------------------");

    return app.exec();
}
