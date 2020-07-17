#pragma once

#include <QObject>
#include <QHash>
#include <QList>
#include <QString>
#include "TaoObject.h"
class Trans : public QObject, public TaoObject
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
    void init() override;

    void uninit() override;

    void beforeUiReady(QQmlContext* ctx) override;

    void afterUiReady() override;
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

    void transStringChanged();

    void langLoaded(const QString &lang);

    void folderLoaded(const QString &folder);

protected:
    void setLanguages(const QStringList &languages);

    void initEnglish();
private:
    QString m_currentLang;
    // <"English", <"key", "value">>
    QHash<QString, QHash<QString, QString>> m_map;
    QStringList m_languages;
    QString m_transString;
};

