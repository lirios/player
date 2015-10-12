#include <QtGui/QGuiApplication>
typedef QGuiApplication Application;
#include <QtQml/QQmlApplicationEngine>
#include <QtQml/QQmlContext>
#include <QCommandLineParser>
#include <iostream>
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
    /*
    QCommandLineParser parser;
    parser.setApplicationDescription("Liri Player");
    parser.addHelpOption();
    parser.addVersionOption();
    parser.addPositionalArgument("source", QGuiApplication::translate("main", "Source file to copy."));
    parser.process(app);
    const QStringList args = parser.positionalArguments();
    */

    QQmlApplicationEngine appEngine;
    appEngine.load(QUrl("qrc:/qml/BaseApplication.qml"));
    appEngine.rootContext()->setContextProperty("G_Cursor",new Cursor);
    /*
    QObject *rootObject = appEngine.rootObjects().first();
    std::cout << args.at(0).toStdString();
    //if(args.at(0).toStdString() != "") {
      //  rootObject->setProperty("cliFile", args.at(0));
    //}
    */
    return app.exec();
}
