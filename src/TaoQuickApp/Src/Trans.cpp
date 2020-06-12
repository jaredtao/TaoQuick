#include "Trans.h"
#include "FileReadWrite.h"
const static auto cEnglisthStr =  QStringLiteral("Englisth");
const static auto cChineseStr = QStringLiteral("简体中文");
const static auto cCNStr = QStringLiteral("cn");
Trans::Trans(QObject *parent) : QObject(parent)
{
    setCurrentLang(cEnglisthStr);
}

void Trans::load(const QString &filePath)
{
    QJsonObject rootObj;
    if(!TaoCommon::readJsonFile(filePath, rootObj))
    {
        return;
    }
    setLanguages(rootObj.value("lang").toVariant().toStringList());
    const auto &trans = rootObj.value("trans").toArray();
    for (auto i : trans)
    {
        auto transObj = i.toObject();
        QString source = transObj.value("key").toString();
        for (auto k : transObj.keys())
        {
            if (k == "key")
            {
                continue;
            }
            m_map[k][source] = transObj.value(k).toString();
        }
    }
    emit transStringChanged();
}

QString Trans::trans(const QString &source) const
{
    if (currentLang() == cChineseStr)
    {
        return m_map.value(cCNStr).value(source, source);
    }
    return source;
}

void Trans::setCurrentLang(const QString &currentLang)
{
    if (m_currentLang == currentLang)
        return;

    m_currentLang = currentLang;
    emit currentLangChanged(m_currentLang);
    emit transStringChanged();
}

void Trans::setLanguages(const QStringList &languages)
{
    if (m_languages == languages)
        return;

    m_languages = languages;
    emit languagesChanged(m_languages);
    emit transStringChanged();
}

