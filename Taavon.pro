QT += quick
QT += widgets
QT += core
QT += network

RCC_DIR = Build/
OBJECTS_DIR = Build/
MOC_DIR = Build/
QMLCACHE_DIR = Build/

CONFIG += c++11

SOURCES += Sources/main.cpp \
    Sources/tvn_csv.cpp \
    Sources/tvn_utility.cpp \
    Sources/tvn_config.cpp \
    Sources/tvn_chapar.cpp \
    Sources/tvn_image.cpp

RESOURCES += Qml/ui.qrc \
             Resources/fonts.qrc \
    Qml/ui.qrc

OTHER_FILES += Qml/*.qml

DISTFILES += \
    Qml/TvnButton.qml \
    Qml/TvnSearch.qml \
    Qml/TvnFileElement.qml \
    Qml/TvnLabel.qml \
    Qml/TvnListFile.qml \
    Qml/TvnComboBox.qml \
    Qml/TvnComboBoxItem.qml \
    Qml/TvnHeader.qml \
    Qml/TvnHeaderLabel.qml \
    Qml/TvnSearchNumberBtn.qml \
    Qml/TvnSearchStringBtn.qml \
    Qml/TvnTableItem.qml \
    Qml/TvnTable.qml \
    Qml/TvnViewFile.qml \
    Qml/TvnEditFile.qml \
    Qml/main.qml \
    Qml/TvnConstants.qml \
    Qml/TvnDetail.qml \
    Qml/TvnDetailImage.qml \
    Qml/TvnDetailLabel.qml \
    Qml/TvnImageBtn.qml \
    Qml/TvnRoundBtn.qml \

HEADERS += \
    Sources/tvn_csv.h \
    Sources/tvn_utility.h \
    Sources/tvn_config.h \
    Sources/tvn_chapar.h \
    Sources/tvn_image.h
