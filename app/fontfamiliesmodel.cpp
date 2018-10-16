/****************************************************************************
 * This file is part of Liri.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

#include <QFontDatabase>

#include "fontfamiliesmodel.h"

FontFamiliesModel::FontFamiliesModel(QObject *parent)
    : QAbstractListModel(parent)
{
    QFontDatabase database;
    QStringList families = database.families();
    for (const QString &family : families) {
        if (family.contains(QLatin1String("mono"), Qt::CaseInsensitive))
            m_families.append(family);
    }
}

QHash<int,QByteArray> FontFamiliesModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles.insert(TextRole, QByteArray("text"));
    return roles;
}

int FontFamiliesModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_families.count();
}

QVariant FontFamiliesModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    switch (role) {
    case Qt::DisplayRole:
    case TextRole:
        return m_families.at(index.row());
    default:
        break;
    }

    return QVariant();
}
