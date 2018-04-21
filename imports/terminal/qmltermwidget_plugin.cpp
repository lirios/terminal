#include <QStandardPaths>

#include "qmltermwidget_plugin.h"

#include "TerminalDisplay.h"
#include "ksession.h"

#include <qqml.h>
#include <QQmlEngine>

using namespace Konsole;

void QmltermwidgetPlugin::registerTypes(const char *uri)
{
    // @uri Liri.Terminal
    
    qmlRegisterType<TerminalDisplay>(uri, 1, 0, "QMLTermWidget");
    qmlRegisterType<KSession>(uri, 1, 0, "QMLTermSession");
}

void QmltermwidgetPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    QQmlExtensionPlugin::initializeEngine(engine, uri);

    QString colorSchemesPath = QStandardPaths::locate(
                QStandardPaths::GenericDataLocation,
                QLatin1String("liri-terminal/color-schemes"),
                QStandardPaths::LocateDirectory);
    if (!colorSchemesPath.isEmpty())
        qputenv("COLORSCHEMES_DIR", colorSchemesPath.toUtf8());

    QString kbLayoutsPath = QStandardPaths::locate(
                QStandardPaths::GenericDataLocation,
                QLatin1String("liri-terminal/kb-layouts"),
                QStandardPaths::LocateDirectory);
    if (!kbLayoutsPath.isEmpty())
        qputenv("KB_LAYOUT_DIR", kbLayoutsPath.toUtf8());
}
