QT += quick
QT += widgets
QT += core
QT += network

RCC_DIR = Build/
OBJECTS_DIR = Build/
MOC_DIR = Build/
QMLCACHE_DIR = Build/

CONFIG += c++11

SOURCES += Sources/main.cpp

RESOURCES += Qml/ui.qrc \
             Resources/fonts.qrc

OTHER_FILES += Qml/*.qml


# Additional import path used to resolve QML modules in Qt Creator's code model
#QML_IMPORT_PATH += Qml/

DISTFILES += \
    Qml/TvnButton.qml \
    Qml/TvnSearchBtn.qml \
    Qml/TvnSearch.qml
