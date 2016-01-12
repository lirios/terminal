//
// Created by zigapk on 12.1.2016.
//

#include "ActionHandler.h"

ActionHandler::ActionHandler(QObject *parent) :
        QObject(parent)
{
}

void ActionHandler::newWindow() {
    system("papyros-terminal &");
}