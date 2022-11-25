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
    Sources/tvn_config.cpp

RESOURCES += Qml/ui.qrc \
             Resources/fonts.qrc \
    Qml/ui.qrc

OTHER_FILES += Qml/*.qml

DISTFILES += \
    Qml/TvnButton.qml \
    Qml/TvnSearch.qml \
    Qml/TvnFileElement.qml \
    Qml/TvnLabel.qml \
    Qml/TvnFileList.qml \
    Qml/TvnComboBox.qml \
    Qml/TvnComboBoxItem.qml \
    Qml/TvnHeader.qml \
    Qml/TvnHeaderLabel.qml \
    Qml/TvnSearchNumberBtn.qml \
    Qml/TvnSearchStringBtn.qml \
    Qml/TvnDetail.qml \
    Qml/TvnDetailLabel.qml \
    Qml/TvnTableItem.qml \
    Qml/TvnTable.qml \
    Qml/TvnViewFile.qml \
    Qml/TvnTableItem.qml \
    Qml/TvnTable.qml \
    Qml/TvnSearchStringBtn.qml \
    Qml/TvnSearchNumberBtn.qml \
    Qml/TvnSearch.qml \
    Qml/TvnLabel.qml \
    Qml/TvnHeaderLabel.qml \
    Qml/TvnHeader.qml \
    Qml/TvnFileList.qml \
    Qml/TvnFileElement.qml \
    Qml/TvnEditFile.qml \
    Qml/TvnDetailLabel.qml \
    Qml/TvnDetail.qml \
    Qml/TvnConstants.qml \
    Qml/TvnComboBoxItem.qml \
    Qml/TvnComboBox.qml \
    Qml/TvnButton.qml \
    Qml/main.qml

HEADERS += \
    Sources/tvn_csv.h \
    Sources/tvn_utility.h \
    Sources/tvn_config.h
