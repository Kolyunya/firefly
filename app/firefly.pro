TEMPLATE = app

QT += qml quick widgets bluetooth

SOURCES += main.cpp

RESOURCES += qml.qrc

CONFIG += c++11

RC_FILE = firefly.rc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS +=
