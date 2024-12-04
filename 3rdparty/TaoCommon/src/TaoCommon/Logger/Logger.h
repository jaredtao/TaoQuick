#pragma once
#include "TaoCommonGlobal.h"
#include <QDebug>
#include <QString>
namespace Logger
{
#ifdef _DEBUG
#	define LOG_DEBUG qDebug() << __FILE__ << __LINE__
#	define LOG_INFO  qInfo() << __FILE__ << __LINE__
#	define LOG_WARN  qWarning() << __FILE__ << __LINE__
#	define LOG_CRIT  qCritical() << __FILE__ << __LINE__
#else
#	define LOG_DEBUG qDebug()
#	define LOG_INFO  qInfo()
#	define LOG_WARN  qWarning()
#	define LOG_CRIT  qCritical()
#endif
// 初始化Log存储。包括创建Log文件夹、删除超过最大数的log。
// logPath 存储路径
// logMaxCount 最大数
void TAO_API initLog(const QString& logPath = QStringLiteral("Log"), int logMaxCount = 1024);

void TAO_API initDebugMessageFormat();
} // namespace Logger
