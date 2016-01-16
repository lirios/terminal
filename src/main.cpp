#include <QApplication>
#include <QQmlApplicationEngine>
#include "ActionHandler.h"
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    app.setOrganizationName("Papyros");
    app.setOrganizationDomain("papyros.io");
    app.setApplicationName("Terminal");

#if QT_VERSION >= QT_VERSION_CHECK(5, 7, 0)
    app.setDesktopFileName("io.papyros.Terminal.desktop");
#endif

    // Set the X11 WML_CLASS so X11 desktops can find the desktop file
    qputenv("RESOURCE_NAME", "io.papyros.Terminal");

    QQmlApplicationEngine engine;

    ActionHandler actionHandler;

    QQmlContext *ctx = engine.rootContext();
    ctx->setContextProperty("actionHandler", &actionHandler);
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    return app.exec();
}
