//
// Created by zigapk on 12.1.2016.
//

#ifndef IO_PAPYROS_TERMINAL_RECEIVER_H
#define IO_PAPYROS_TERMINAL_RECEIVER_H

#include <QtCore/qplugin.h>
#include <QObject>

class ActionHandler : public QObject {
    Q_OBJECT
public:
    explicit ActionHandler(QObject *parent = 0);
public slots:
    void newWindow();
};


#endif //IO_PAPYROS_TERMINAL_RECEIVER_H
