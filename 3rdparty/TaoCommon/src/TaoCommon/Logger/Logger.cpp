#include "Logger.h"
#include "LoggerTemplate.h"

#include <QCoreApplication>
#include <QDateTime>
#include <QDebug>
#include <QDir>
#include <QMutex>
#include <QTextStream>
#include <string>
#include <QByteArrayView>
#include <QThread>

#ifdef Q_OS_WIN
#	include <Windows.h>
#else
#	include <cstdio>
#endif

namespace Logger
{
static QString gLogDir;
static int	   gLogMaxCount;

static void outputMessage(QtMsgType type, const QMessageLogContext& context, const QString& msg);


static void removeOldLog()
{
	QDir dir(gLogDir);
	if (!dir.exists())
	{
		return;
	}
	QStringList infoList = dir.entryList(QDir::Files, QDir::Name);
	while (infoList.size() > gLogMaxCount)
	{
		dir.remove(infoList.first());
		infoList.removeFirst();
	}
}
void initLog(const QString& logPath, int logMaxCount)
{


	qInstallMessageHandler(outputMessage);


	gLogDir		 = QCoreApplication::applicationDirPath() + QStringLiteral("/") + logPath;
	gLogMaxCount = logMaxCount;
	QDir dir(gLogDir);
	if (!dir.exists())
	{
		dir.mkpath(dir.absolutePath());
	} else {
		removeOldLog();
	}
}

static QString qCleanupFileinfo(const QString& file)
{
	return file.mid( file.lastIndexOf(QDir::separator()) + 1);
}
static QByteArray qCleanupFuncinfo(QByteArray info)
{
	// Strip the function info down to the base function name
	// note that this throws away the template definitions,
	// the parameter types (overloads) and any const/volatile qualifiers.

	if (info.isEmpty())
		return info;

	int pos;

		   // Skip trailing [with XXX] for templates (gcc), but make
		   // sure to not affect Objective-C message names.
	pos = info.size() - 1;
	if (info.endsWith(']') && !(info.startsWith('+') || info.startsWith('-')))
	{
		while (--pos)
		{
			if (info.at(pos) == '[')
				info.truncate(pos);
		}
	}

		   // operator names with '(', ')', '<', '>' in it
	static const char operator_call[]			  = "operator()";
	static const char operator_lessThan[]		  = "operator<";
	static const char operator_greaterThan[]	  = "operator>";
	static const char operator_lessThanEqual[]	  = "operator<=";
	static const char operator_greaterThanEqual[] = "operator>=";

		   // canonize operator names
	info.replace("operator ", "operator");

		   // remove argument list
	forever
	{
		int parencount = 0;
		pos			   = info.lastIndexOf(')');
		if (pos == -1)
		{
			// Don't know how to parse this function name
			return info;
		}

			   // find the beginning of the argument list
		--pos;
		++parencount;
		while (pos && parencount)
		{
			if (info.at(pos) == ')')
				++parencount;
			else if (info.at(pos) == '(')
				--parencount;
			--pos;
		}
		if (parencount != 0)
			return info;

		info.truncate(++pos);

		if (info.at(pos - 1) == ')')
		{
			if (info.indexOf(operator_call) == pos - (int)strlen(operator_call))
				break;

				   // this function returns a pointer to a function
				   // and we matched the arguments of the return type's parameter list
				   // try again
			info.remove(0, info.indexOf('('));
			info.chop(1);
			continue;
		}
		else
		{
			break;
		}
	}

		   // find the beginning of the function name
	int parencount	  = 0;
	int templatecount = 0;
	--pos;

		   // make sure special characters in operator names are kept
	if (pos > -1)
	{
		switch (info.at(pos))
		{
			case ')':
				if (info.indexOf(operator_call) == pos - (int)strlen(operator_call) + 1)
					pos -= 2;
				break;
			case '<':
				if (info.indexOf(operator_lessThan) == pos - (int)strlen(operator_lessThan) + 1)
					--pos;
				break;
			case '>':
				if (info.indexOf(operator_greaterThan) == pos - (int)strlen(operator_greaterThan) + 1)
					--pos;
				break;
			case '=':
			{
				int operatorLength = (int)strlen(operator_lessThanEqual);
				if (info.indexOf(operator_lessThanEqual) == pos - operatorLength + 1)
					pos -= 2;
				else if (info.indexOf(operator_greaterThanEqual) == pos - operatorLength + 1)
					pos -= 2;
				break;
			}
			default:
				break;
		}
	}

	while (pos > -1)
	{
		if (parencount < 0 || templatecount < 0)
			return info;

		char c = info.at(pos);
		if (c == ')')
			++parencount;
		else if (c == '(')
			--parencount;
		else if (c == '>')
			++templatecount;
		else if (c == '<')
			--templatecount;
		else if (c == ' ' && templatecount == 0 && parencount == 0)
			break;

		--pos;
	}
	info = info.mid(pos + 1);

		   // remove trailing '*', '&' that are part of the return argument
	while ((info.at(0) == '*') || (info.at(0) == '&'))
		info = info.mid(1);

		   // we have the full function name now.
		   // clean up the templates
	while ((pos = info.lastIndexOf('>')) != -1)
	{
		if (!info.contains('<'))
			break;

			   // find the matching close
		int end		  = pos;
		templatecount = 1;
		--pos;
		while (pos && templatecount)
		{
			char c = info.at(pos);
			if (c == '>')
				++templatecount;
			else if (c == '<')
				--templatecount;
			--pos;
		}
		++pos;
		info.remove(pos, end - pos + 1);
	}

	return info;
}

static void debugMessageOutput(QtMsgType type, const QMessageLogContext& context, const QString& msg)
{
	(void)type;

	const QByteArray& localMsg = msg.toLocal8Bit();

	const QString& fileBaseName = qCleanupFileinfo(context.file);
	const QByteArray& func		   = qCleanupFuncinfo(context.function);

	const auto& time	 = QTime::currentTime().toString("hh:mm:ss.zzz");
	const auto& threadId = QThread::currentThreadId();
	fprintf(
		stderr,
		"[%s %llu %s %s %d] %s\n",
		time.toStdString().c_str(),
		(uint64_t)threadId,
		fileBaseName.toStdString().c_str(),
		func.constData(),
		context.line,
		localMsg.constData());
}
void initDebugMessageFormat()
{
	qInstallMessageHandler(debugMessageOutput);
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
		removeOldLog();
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
