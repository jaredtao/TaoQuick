#include "Trans.h"
#include "FileReadWrite.h"
#include <QDir>
const static auto cEnglisthStr = QStringLiteral("English");
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
    setLanguages(m_map.uniqueKeys());
    setCurrentLang(cEnglisthStr);
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

void Trans::initEnglish()
{
    if (!m_map.contains(cEnglisthStr)) {
        const auto& map = m_map.value(m_map.keys().first());
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
//    qWarning() << "m_currentLang" << m_currentLang;
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
