#include "Trans.h"
#include "filereadwrite.h"
#include <QDir>
const static auto cEnglisthStr = QStringLiteral("English");
const static auto cChineseStr = QStringLiteral("简体中文");
Trans::Trans(QObject* parent)
    : QObject(parent)
{
}

void Trans::loadFolder(const QString& folder)
{
    QDir dir(folder);
    auto infos = dir.entryInfoList({ "language_*.json" }, QDir::Files);
    for (auto info : infos) {
        QString lang;
        load(lang, info.absoluteFilePath());
    }
    initEnglish();
    auto langs = m_map.uniqueKeys();
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
    emit transStringChanged();
}

bool Trans::load(QString& lang, const QString& filePath)
{
    lang.clear();
    QJsonObject rootObj;
    if (!TaoCommon::readJsonFile(filePath, rootObj)) {
        return false;
    }
    lang = rootObj.value("lang").toString();
    const auto& trans = rootObj.value("trans").toArray();
    for (auto i : trans) {
        auto transObj = i.toObject();
        QString key = transObj.value("key").toString();
        QString value = transObj.value("value").toString();
        m_map[lang][key] = value;
    }
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
        for (auto key : map.uniqueKeys()) {
            m_map[cEnglisthStr][key] = key;
        }
    }
}

QString Trans::trans(const QString& source) const
{
    return m_map.value(m_currentLang).value(source, source);
//    auto value = m_map.value(m_currentLang).value(source, source);
//    qWarning() <<m_currentLang << source << value;
//    return value;
}

void Trans::setCurrentLang(const QString& currentLang)
{
    if (m_currentLang == currentLang)
        return;

    m_currentLang = currentLang;
    emit currentLangChanged(m_currentLang);
    emit transStringChanged();
}

void Trans::setLanguages(const QStringList& languages)
{
    if (m_languages == languages)
        return;

    m_languages = languages;
    emit languagesChanged(m_languages);
    emit transStringChanged();
}
