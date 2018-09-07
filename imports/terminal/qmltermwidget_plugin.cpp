#include <QStandardPaths>

#include "qmltermwidget_plugin.h"

#include "TerminalDisplay.h"
#include "ksession.h"
#include "ColorScheme.h"

#include <qqml.h>
#include <QQmlEngine>

using namespace Konsole;

static QObject *colorschememanager_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    return ColorSchemeManager::instance();
}

void QmltermwidgetPlugin::registerTypes(const char *uri)
{
    // @uri Liri.Terminal
    
    qmlRegisterType<TerminalDisplay>(uri, 1, 0, "QMLTermWidget");
    qmlRegisterType<KSession>(uri, 1, 0, "QMLTermSession");
    qmlRegisterUncreatableType<Konsole::ColorScheme>(uri, 1, 0, "ColorScheme", QStringLiteral("Not instantiatable"));
    qmlRegisterSingletonType<ColorSchemeManager>(uri, 1, 0, "ColorSchemeManager", colorschememanager_provider);
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
