#include <QtGui/QGuiApplication>
typedef QGuiApplication Application;
#include <QtQml/QQmlApplicationEngine>
#include <QtQml/QQmlContext>
#include <QCommandLineParser>
#include <QDebug>
#include <QmlVlc.h>
#include <QmlVlc/QmlVlcConfig.h>
#include <QStandardPaths>
#include "cursor/cursor.h"

//qmlRegisterSingletonType<QmlEnvironmentVariable>("MyModule", 1, 0,
  //  "EnvironmentVariable", qmlenvironmentvariable_singletontype_provider);

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

    QUrl musicDir = QUrl::fromLocalFile(QStandardPaths::standardLocations(QStandardPaths::MusicLocation).last());
    QUrl moviesDir = QUrl::fromLocalFile(QStandardPaths::standardLocations(QStandardPaths::MoviesLocation).last());
    appEngine.rootContext()->setContextProperty("musicDir", musicDir);
    appEngine.rootContext()->setContextProperty("moviesDir", moviesDir);

    appEngine.rootContext()->setContextProperty("G_Cursor",new Cursor);

    appEngine.load(QUrl("qrc:/qml/BaseApplication.qml"));

    /*
    QObject *rootObject = appEngine.rootObjects().first();
    std::cout << args.at(0).toStdString();
    //if(args.at(0).toStdString() != "") {
      //  rootObject->setProperty("cliFile", args.at(0));
    //}
    */
    return app.exec();

// ...

}
