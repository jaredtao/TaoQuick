#include "Logger.h"
#include "LoggerTemplate.h"

#include <QCoreApplication>
#include <QDateTime>
#include <QDir>
#include <QMutex>

#include <string>

#ifdef Q_OS_WIN
#include <Windows.h>
#else
#include <cstdio>
#endif

namespace Logger {
static QString gLogDir;
static int gLogMaxCount;

static void outputMessage(QtMsgType type, const QMessageLogContext& context, const QString& msg);

void initLog(const QString& logPath, int logMaxCount)
{
    qInstallMessageHandler(outputMessage);
    gLogDir = QCoreApplication::applicationDirPath() + "/" + logPath;
    gLogMaxCount = logMaxCount;
    QDir dir(gLogDir);
    if (!dir.exists()) {
        dir.mkpath(dir.absolutePath());
    }
    QStringList infoList = dir.entryList(QDir::Files, QDir::Name);
    while (infoList.size() > gLogMaxCount) {
        dir.remove(infoList.first());
        infoList.removeFirst();
    }
}
static void outputMessage(QtMsgType type, const QMessageLogContext& context, const QString& msg)
{
    static const QString messageTemp = QString("<div class=\"%1\">%2</div>\r\n");
    static const char typeList[] = { 'd', 'w', 'c', 'f', 'i' };
    static QMutex mutex;
    static QFile file;
    static QTextStream textStream;
    Q_UNUSED(context);
    QDateTime dt = QDateTime::currentDateTime();

    //每小时一个文件
    QString fileNameDt = dt.toString("yyyy-MM-dd_hh");

    //每分钟一个文件
    //QString fileNameDt = dt.toString("yyyy-MM-dd_hh_mm");

    //每天一个文件
    //QString fileNameDt = dt.toString("yyyy-MM-dd_");
    QString contentDt = dt.toString("yyyy-MM-dd hh:mm:ss");
    QString message = QString("%1 %2").arg(contentDt).arg(msg);
    QString htmlMessage = messageTemp.arg(typeList[static_cast<int>(type)]).arg(message);
    QString newfileName = QString("%1/%2_log.html").arg(gLogDir).arg(fileNameDt);
    mutex.lock();
    if (file.fileName() != newfileName) {
        if (file.isOpen()) {
            file.close();
        }
        file.setFileName(newfileName);
        bool exist = file.exists();
        file.open(QIODevice::WriteOnly | QIODevice::Append);
        textStream.setDevice(&file);
        textStream.setCodec("UTF-8");
        if (!exist) {
            textStream << logTemplate << "\r\n";
        }
    }
    textStream << htmlMessage;
    file.flush();
    mutex.unlock();
#ifdef Q_OS_WIN
    ::OutputDebugString(message.toStdWString().data());
    ::OutputDebugString(L"\r\n");
#else
    fprintf(stderr, "%s\n", message.toStdString().data());
#endif
}
} // namespace Logger
