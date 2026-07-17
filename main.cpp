#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "audioengine.h"
#include <QQmlContext>
#include "taalmanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    AudioEngine audioEngine;
    TaalManager tm;
    audioEngine.setTaalManager(&tm);
    QQmlApplicationEngine engine;
    //Code intentionally omitted to protect intellectual property//

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("LehraApp", "Main");

    app.setApplicationDisplayName("Lehra App - Anish Savkar");

   return QGuiApplication::exec();
}
