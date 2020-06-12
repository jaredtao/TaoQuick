#pragma once

#include <QObject>
#include <QHash>
#include <QList>
#include <QString>
class Trans : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentLang READ currentLang WRITE setCurrentLang NOTIFY currentLangChanged)
    Q_PROPERTY(QStringList languages READ languages NOTIFY languagesChanged)
    Q_PROPERTY(QString transString READ transString NOTIFY transStringChanged)
public:
    explicit Trans(QObject *parent = nullptr);
    void load(const QString &filePath);
public:
    const QString &currentLang() const
    {
        return m_currentLang;
    }


    const QStringList &languages() const
    {
        return m_languages;
    }

    const QString &transString() const
    {
        return m_transString;
    }

public slots:
    QString trans(const QString &source) const;

    void setCurrentLang(const QString &currentLang);
signals:
    void currentLangChanged(const QString &currentLang);

    void languagesChanged(const QStringList &languages);

    void transStringChanged();

protected:

    void setLanguages(const QStringList &languages);

private:

    QString m_currentLang;

    // <en, <"key", "value">>
    QHash<QString, QHash<QString, QString>> m_map;
    QStringList m_languages;
    QString m_transString;
};

