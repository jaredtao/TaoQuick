#include "Logger.h"
#include "LoggerTemplate.h"

#include <QCoreApplication>
#include <QDateTime>
#include <QDebug>
#include <QDir>
#include <QMutex>
#include <QTextStream>
#include <string>

#ifdef Q_OS_WIN
#include <Windows.h>
#else
#include <cstdio>
#endif

namespace Logger
{
static QString gLogDir;
static int	   gLogMaxCount;

static void outputMessage(QtMsgType type, const QMessageLogContext& context, const QString& msg);
static void outputMessageAsync(QtMsgType type, const QMessageLogContext& context, const QString& msg);

void initLog(const QString& logPath, int logMaxCount, bool async)
{
	if (async)
	{
		qInstallMessageHandler(outputMessageAsync);
	}
	else
	{
		qInstallMessageHandler(outputMessage);
	}

	gLogDir		 = QCoreApplication::applicationDirPath() + QStringLiteral("/") + logPath;
	gLogMaxCount = logMaxCount;
	QDir dir(gLogDir);
	if (!dir.exists())
	{
		dir.mkpath(dir.absolutePath());
	}
	QStringList infoList = dir.entryList(QDir::Files, QDir::Name);
	while (infoList.size() > gLogMaxCount)
	{
		dir.remove(infoList.first());
		infoList.removeFirst();
	}
}
static void outputMessageAsync(QtMsgType type, const QMessageLogContext& context, const QString& msg)
{
	static const QString messageTemp = QStringLiteral("<div class=\"%1\">%2</div>\r\n");
	static const char	 typeList[]	 = { 'd', 'w', 'c', 'f', 'i' };
	static QMutex		 mutex;
	static QFile		 file;
	static QTextStream	 textStream;
	static uint			 count	  = 0;
	static const uint	 maxCount = 512;
	Q_UNUSED(context)
	QDateTime dt = QDateTime::currentDateTime();

	// 每小时一个文件
	QString fileNameDt = dt.toString(QStringLiteral("yyyy-MM-dd_hh"));

	// 每分钟一个文件
	//  QString fileNameDt = dt.toString("yyyy-MM-dd_hh_mm");

	QString contentDt	= dt.toString(QStringLiteral("yyyy-MM-dd hh:mm:ss"));
	QString message		= QStringLiteral("%1 %2").arg(contentDt).arg(msg);
	QString htmlMessage = messageTemp.arg(typeList[static_cast<int>(type)]).arg(message);
	QString newfileName = QStringLiteral("%1/%2_log.html").arg(gLogDir).arg(fileNameDt);
	mutex.lock();
	if (file.fileName() != newfileName)
	{
		if (file.isOpen())
		{
			file.close();
		}
		file.setFileName(newfileName);
		bool exist = file.exists();
		file.open(QIODevice::WriteOnly | QIODevice::Append);
		textStream.setDevice(&file);
#if QT_VERSION >= QT_VERSION_CHECK(6, 0, 0)
		textStream.setEncoding(QStringConverter::Utf8);
#else
		textStream.setCodec("UTF-8");
#endif
		if (!exist)
		{
			textStream << logTemplate << "\r\n";
		}
	}
	textStream << htmlMessage;
	textStream.flush();
	count += htmlMessage.length();
	if (count >= maxCount)
	{
		file.close();
		file.open(QIODevice::WriteOnly | QIODevice::Append);
	}
	mutex.unlock();
#ifdef Q_OS_WIN
	::OutputDebugString(message.toStdWString().data());
	::OutputDebugString(L"\r\n");
#else
	fprintf(stderr, "%s", message.toStdString().data());
#endif
}
static void outputMessage(QtMsgType type, const QMessageLogContext& context, const QString& msg)
{
	static const QString messageTemp = QStringLiteral("<div class=\"%1\">%2</div>\r\n");
	static const char	 typeList[]	 = { 'd', 'w', 'c', 'f', 'i' };
	static QMutex		 mutex;

	Q_UNUSED(context)
	QDateTime dt = QDateTime::currentDateTime();

	// 每小时一个文件
	QString fileNameDt = dt.toString(QStringLiteral("yyyy-MM-dd_hh"));

	// 每分钟一个文件
	//  QString fileNameDt = dt.toString("yyyy-MM-dd_hh_mm");

	QString contentDt	= dt.toString(QStringLiteral("yyyy-MM-dd hh:mm:ss"));
	QString message		= QStringLiteral("%1 %2").arg(contentDt).arg(msg);
	QString htmlMessage = messageTemp.arg(typeList[static_cast<int>(type)]).arg(message);
	QFile	file(QStringLiteral("%1/%2_log.html").arg(gLogDir).arg(fileNameDt));
	mutex.lock();

	bool exist = file.exists();
	file.open(QIODevice::WriteOnly | QIODevice::Append);
	QTextStream textStream(&file);
#if QT_VERSION >= QT_VERSION_CHECK(6, 0, 0)
	textStream.setEncoding(QStringConverter::Utf8);
#else
	textStream.setCodec("UTF-8");
#endif
	if (!exist)
	{
		textStream << logTemplate << "\r\n";
	}
	textStream << htmlMessage;
	file.close();
	mutex.unlock();
#ifdef Q_OS_WIN
	::OutputDebugString(message.toStdWString().data());
	::OutputDebugString(L"\r\n");
#else
	fprintf(stderr, "%s", message.toStdString().data());
#endif
}
} // namespace Logger
