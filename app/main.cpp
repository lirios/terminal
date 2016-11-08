/*
 * This file is part of Terminal.
 *
 * Copyright (C) 2016 Ricardo Vieira <ricardo.vieira@tecnico.ulisboa.pt>
 *               2016 Žiga Patačko Koderman <ziga.patacko@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>

#include "ActionHandler.h"

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    app.setOrganizationName(QLatin1String("Liri"));
    app.setOrganizationDomain(QLatin1String("liri.io"));
    app.setApplicationName(QLatin1String("Terminal"));
    app.setDesktopFileName(QLatin1String("io.liri.Terminal.desktop"));

    // Set the X11 WML_CLASS so X11 desktops can find the desktop file
    qputenv("RESOURCE_NAME", "io.liri.Terminal");

    if (QQuickStyle::name().isEmpty())
        QQuickStyle::setStyle("Material");

    QQmlApplicationEngine engine;

    ActionHandler actionHandler(argv[0]);

    QQmlContext *ctx = engine.rootContext();
    ctx->setContextProperty("actionHandler", &actionHandler);
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    return app.exec();
}
