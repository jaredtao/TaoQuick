#pragma once
#include <QDebug>
#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QString>
#include "Logger/Logger.h"
namespace TaoCommon {
[[maybe_unused]]
static bool readFile(const QString &filePath, QByteArray &content)
{
    QFile file(filePath);
    if (!file.open(QFile::ReadOnly)) {
        LOG_WARN << "open file " << filePath << "failed:" << file.errorString();
        return false;
    }
    content = file.readAll();
    file.close();
    return true;
}
[[maybe_unused]]
static bool readJson(const QByteArray &data, QJsonDocument &doc)
{
    QJsonParseError err;
    doc = QJsonDocument::fromJson(data, &err);
    if (doc.isNull()) {
        LOG_WARN << "parse json failed:" << err.errorString();
        return false;
    }
    return true;
}
[[maybe_unused]]
static bool readJson(const QByteArray &data, QJsonArray &array)
{
    QJsonDocument doc;
    bool ok = readJson(data, doc);
    if (ok) {
        array = doc.array();
    }
    return ok;
}
[[maybe_unused]]
static bool readJson(const QByteArray &data, QJsonObject &object)
{
    QJsonDocument doc;
    bool ok = readJson(data, doc);
    if (ok) {
        object = doc.object();
    }
    return ok;
}
[[maybe_unused]]
static bool readJsonFile(const QString &filePath, QJsonDocument &jsonDoc)
{
    QByteArray data;
    if (!readFile(filePath, data)) {
        return false;
    }
    return readJson(data, jsonDoc);
}
[[maybe_unused]]
static bool readJsonFile(const QString &filePath, QJsonObject &jsonObj)
{
    QByteArray data;
    if (!readFile(filePath, data)) {
        return false;
    }
    return readJson(data, jsonObj);
}
[[maybe_unused]]
static bool readJsonFile(const QString &filePath, QJsonArray &jsonArray)
{
    QByteArray data;
    if (!readFile(filePath, data)) {
        return false;
    }
    return readJson(data, jsonArray);
}
[[maybe_unused]]
static bool writeFile(const QString &filePath, const QByteArray &content)
{
    QFile file(filePath);
    if (!file.open(QFile::WriteOnly)) {
        LOG_WARN << "open file " << filePath << "failed:" << file.errorString();
        return false;
    }
    file.write(content);
    file.close();
    return true;
}
[[maybe_unused]]
static bool writeJsonFile(const QString &filePath, const QJsonDocument &doc)
{
    return writeFile(filePath, doc.toJson());
}
[[maybe_unused]]
static bool writeJsonFile(const QString &filePath, const QJsonArray &jsonArray)
{
    return writeJsonFile(filePath, QJsonDocument(jsonArray));
}
[[maybe_unused]]
static bool writeJsonFile(const QString &filePath, const QJsonObject &jsonObj)
{
    return writeJsonFile(filePath, QJsonDocument(jsonObj));
}

} // namespace TaoCommon
