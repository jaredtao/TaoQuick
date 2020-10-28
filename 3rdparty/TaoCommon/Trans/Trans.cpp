#include "Trans.h"
#include "filereadwrite.h"
#include <QDir>
#include <QQmlContext>
#include <QCoreApplication>
#include <QLocale>
#include <QQuickView>
#include <QQmlEngine>
const static auto cEnglisthStr = u8"English";
const static auto cChineseStr = u8"简体中文";
Trans::Trans(QObject *parent) : QTranslator(parent) {}

void Trans::beforeUiReady(QQmlContext *ctx)
{
    m_ctx = ctx;
    ctx->setContextProperty("trans", this);
    loadFolder(qApp->applicationDirPath() + "/Trans");
    qApp->installTranslator(this);
}

void Trans::afterUiReady() {}

QString Trans::translate(const char *context, const char *sourceText, const char *disambiguation,
                         int n) const
{
    Q_UNUSED(context)
    Q_UNUSED(disambiguation)
    Q_UNUSED(n)

    return trans(sourceText);
}

void Trans::loadFolder(const QString &folder)
{
    QDir dir(folder);
    auto infos = dir.entryInfoList({ "language_*.json" }, QDir::Files);
    QString lang;
    for (const auto &info : infos) {
        load(lang, info.absoluteFilePath());
    }

    initEnglish();
    auto langs = m_map.keys();
    if (langs.contains(cChineseStr)) {
        langs.removeAll(cChineseStr);
        langs.push_front(cChineseStr);
    }
    setLanguages(langs);
    if (m_map.contains(cChineseStr)) {
        setCurrentLang(cChineseStr);
    } else {
        setCurrentLang(cEnglisthStr);
    }
    emit folderLoaded(folder);
}

bool Trans::load(QString &lang, const QString &filePath)
{
    lang.clear();
    QJsonObject rootObj;
    if (!TaoCommon::readJsonFile(filePath, rootObj)) {
        return false;
    }
    lang = rootObj.value("lang").toString();
    const auto &trans = rootObj.value("trans").toArray();
    for (const auto &i : trans) {
        auto transObj = i.toObject();
        QString key = transObj.value("key").toString();
        QString value = transObj.value("value").toString();
        m_map[lang][key] = value;
    }
    emit langLoaded(lang);
    return true;
}

const QString &Trans::currentLang() const
{
    return m_currentLang;
}

const QStringList &Trans::languages() const
{
    return m_languages;
}

const QString &Trans::transString() const
{
    return m_transString;
}

void Trans::initEnglish()
{
    if (!m_map.contains(cEnglisthStr)) {
        QHash<QString, QString> map;
        if (m_map.contains(cChineseStr)) {
            map = m_map.value(cChineseStr);
        } else {
            map = m_map.value(m_map.keys().first());
        }
        for (const auto &key : map.keys()) {
            m_map[cEnglisthStr][key] = key;
        }
    }
}

QString Trans::trans(const QString &source) const
{
    return m_map.value(m_currentLang).value(source, source);
}

void Trans::setCurrentLang(const QString &currentLang)
{
    if (m_currentLang == currentLang)
        return;

    m_currentLang = currentLang;
    emit currentLangChanged(m_currentLang);

#if QT_VERSION >= QT_VERSION_CHECK(5, 10, 0)
    m_ctx->engine()->retranslate();
#else
    emit transStringChanged();
#endif
}

void Trans::setLanguages(const QStringList &languages)
{
    if (m_languages == languages)
        return;

    m_languages = languages;
    emit languagesChanged(m_languages);
}
