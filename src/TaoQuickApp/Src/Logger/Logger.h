#pragma once
#include <QDebug>

namespace Logger {
#ifdef _DEBUG
#define LOG_DEBUG qDebug() << __FILE__ << __LINE__
#define LOG_INFO qInfo() << __FILE__ << __LINE__
#define LOG_WARN qWarning() << __FILE__ << __LINE__
#define LOG_CRIT qCritical() << __FILE__ << __LINE__
#else
#define LOG_DEBUG qDebug() << __FUNCTION__
#define LOG_INFO qInfo() << __FUNCTION__
#define LOG_WARN qWarning() << __FUNCTION__
#define LOG_CRIT qCritical() << __FUNCTION__
#endif
void initLog(const QString& logPath = QStringLiteral("Log"), int logMaxCount = 1024);

} // namespace Logger
