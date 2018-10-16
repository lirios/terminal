/****************************************************************************
 * This file is part of Liri.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2016 Ricardo Vieira <ricardo.vieira@tecnico.ulisboa.pt>
 * Copyright (C) 2016 Žiga Patačko Koderman <ziga.patacko@gmail.com>
 *
 * $BEGIN_LICENSE:GPL3+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>

#include "ActionHandler.h"
#include "fontfamiliesmodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    app.setOrganizationName(QLatin1String("Liri"));
    app.setOrganizationDomain(QLatin1String("liri.io"));
    app.setApplicationName(QLatin1String("Terminal"));
    app.setDesktopFileName(QLatin1String("io.liri.Terminal.desktop"));

    // Set the X11 WM_CLASS so X11 desktops can find the desktop file
    qputenv("RESOURCE_NAME", "io.liri.Terminal");

    QQuickStyle::setStyle("Material");

    QQmlApplicationEngine engine;

    ActionHandler actionHandler(argv[0]);
    FontFamiliesModel familiesModel;

    QQmlContext *ctx = engine.rootContext();
    ctx->setContextProperty("actionHandler", &actionHandler);
    ctx->setContextProperty("fontFamilies", &familiesModel);
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    return app.exec();
}
