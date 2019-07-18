#include "taoquick_plugin.h"
#include <QDebug>

void TaoQuickPlugin::registerTypes(const char *uri)
{
    Q_UNUSED(uri);
    Q_INIT_RESOURCE(Qml);
    qInfo() << "\033[35m" << "Your application is using TaoQuick ";
    qInfo() << " Version:" << TaoVer;
    qInfo() << " Revision:" << TaoREVISION;
    qInfo() << " Author: Jared Tao";
    qInfo() << " You can find more info about TaoQuick in website:"
            << "\033[0m"
            << "\033[31m"
            << "https://github.com/jaredtao";

    qInfo() << "\033[0m\033[32m" << "Good luck to you." << "\033[0m";
}


