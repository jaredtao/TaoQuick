#pragma once

#include <QObject>
#include <QHash>
#include <QList>
#include <QString>
#include <QTranslator>
#include "TaoCommonGlobal.h"
class QQmlContext;
class Trans : public QTranslator
{
    Q_OBJECT
    Q_PROPERTY(QString currentLang READ currentLang WRITE setCurrentLang NOTIFY currentLangChanged)
    Q_PROPERTY(QStringList languages READ languages NOTIFY languagesChanged)
    Q_PROPERTY(QString transString READ transString NOTIFY transStringChanged)
public:
    Trans(QObject *parent = nullptr);

    Q_INVOKABLE void loadFolder(const QString &folder);

    Q_INVOKABLE bool load(QString &lang, const QString &filePath);

public:
    void beforeUiReady(QQmlContext *ctx);

    void afterUiReady();

    QString translate(const char *context, const char *sourceText,
                      const char *disambiguation = nullptr, int n = -1) const override;

public:
    const QString &currentLang() const;

    const QStringList &languages() const;

    const QString &transString() const;

public slots:
    QString trans(const QString &source) const;
    void setCurrentLang(const QString &currentLang);
signals:
    void currentLangChanged(const QString &currentLang);

    void languagesChanged(const QStringList &languages);

    void langLoaded(const QString &lang);

    void folderLoaded(const QString &folder);

    void transStringChanged();

protected:
    void setLanguages(const QStringList &languages);

    void initEnglish();

private:
    QString m_currentLang;
    // <"English", <"key", "value">>
    QHash<QString, QHash<QString, QString>> m_map;
    QStringList m_languages;
    QString m_transString;
    QQmlContext *m_ctx = nullptr;
};
