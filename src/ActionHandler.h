/*
 * Papyros Terminal - The terminal app for Papyros following Material Design
 * Copyright (C) 2016 Žiga Patačko Koderman <ziga.patacko@gmail.com>
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

#ifndef ACTION_HANDLER_H
#define ACTION_HANDLER_H

#include <QtCore/qplugin.h>
#include <QObject>

class ActionHandler : public QObject
{
    Q_OBJECT
public:
    std::string binaryOrigin = "";
    explicit ActionHandler(QObject *parent = 0);
public slots:
    void newWindow();
};

#endif // ACTION_HANDLER_H
