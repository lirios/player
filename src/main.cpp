#include <QtGui/QGuiApplication>
typedef QGuiApplication Application;
#include <QtQml/QQmlApplicationEngine>
#include <QtQml/QQmlContext>


#include <QmlVlc.h>
#include <QmlVlc/QmlVlcConfig.h>

#include "cursor/cursor.h"

int main(int argc, char **argv)
{
    RegisterQmlVlc();
    QmlVlcConfig& config = QmlVlcConfig::instance();
    config.enableAdjustFilter(true);
    config.enableMarqueeFilter(true);
    config.enableLogoFilter(true);
    config.enableDebug(true);

    Application app(argc, argv);
    QQmlApplicationEngine appEngine;
    appEngine.load(QUrl("qrc:/qml/main.qml"));
    appEngine.rootContext()->setContextProperty("G_Cursor",new Cursor);
    return app.exec();
}
