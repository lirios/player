QT += qml quick multimedia core

include(dependencies/QmlVlc/QmlVlc.pri)

INCLUDEPATH += dependencies

SOURCES += src/main.cpp \
    src/cursor/cursor.cpp 

HEADERS += \
    src/cursor/cursor.h


RESOURCES += src/qml.qrc

CONFIG += c++11

macx {
    LIBS += -L/Applications/VLC.app/Contents/MacOS/lib
}

android {
    LIBS += -L$$PWD/android/libs/armeabi-v7a -lvlcjni

    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
}
