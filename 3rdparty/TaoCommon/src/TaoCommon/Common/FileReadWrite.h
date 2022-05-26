#pragma once
#include <QDebug>
#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QString>
#include "Logger/Logger.h"
namespace TaoCommon {

static bool readFile(const QString& filePath, QByteArray& content, QString* errStr = nullptr)
{
    QFile file(filePath);
    if (!file.open(QFile::ReadOnly))
    {
        if (errStr)
        {
            *errStr = file.errorString();
        }
        return false;
    }
    content = file.readAll();
    file.close();
    return true;
}
static bool readJson(const QByteArray& data, QJsonDocument& doc, QString* errStr = nullptr)
{
    QJsonParseError err;
    doc = QJsonDocument::fromJson(data, &err);
    if (doc.isNull())
    {
        if (errStr)
        {
            *errStr = err.errorString();
        }
        return false;
    }
    return true;
}
static bool readJson(const QByteArray& data, QJsonArray& array, QString* errStr = nullptr)
{
    QJsonDocument doc;
    bool		  ok = readJson(data, doc, errStr);
    if (ok)
    {
        array = doc.array();
    }
    return ok;
}
static bool readJson(const QByteArray& data, QJsonObject& object, QString* errStr = nullptr)
{
    QJsonDocument doc;
    bool		  ok = readJson(data, doc, errStr);
    if (ok)
    {
        object = doc.object();
    }
    return ok;
}
static bool readJsonFile(const QString& filePath, QJsonDocument& jsonDoc, QString* errStr = nullptr)
{
    QByteArray data;
    if (!readFile(filePath, data, errStr))
    {
        return false;
    }
    return readJson(data, jsonDoc, errStr);
}
static bool readJsonFile(const QString& filePath, QJsonObject& jsonObj, QString* errStr = nullptr)
{
    QByteArray data;
    if (!readFile(filePath, data, errStr))
    {
        return false;
    }
    return readJson(data, jsonObj, errStr);
}
static bool readJsonFile(const QString& filePath, QJsonArray& jsonArray, QString* errStr = nullptr)
{
    QByteArray data;
    if (!readFile(filePath, data, errStr))
    {
        return false;
    }
    return readJson(data, jsonArray, errStr);
}
static bool writeFile(const QString& filePath, const QByteArray& content, QString* errStr = nullptr)
{
    QFile file(filePath);
    if (!file.open(QFile::WriteOnly))
    {
        if (errStr)
        {
            *errStr = file.errorString();
        }
        return false;
    }
    file.write(content);
    file.close();
    return true;
}
static bool writeJsonFile(const QString& filePath, const QJsonDocument& doc, QString* errStr = nullptr)
{
    return writeFile(filePath, doc.toJson(), errStr);
}
static bool writeJsonFile(const QString& filePath, const QJsonArray& jsonArray, QString* errStr = nullptr)
{
    return writeJsonFile(filePath, QJsonDocument(jsonArray), errStr);
}
static bool writeJsonFile(const QString& filePath, const QJsonObject& jsonObj, QString* errStr = nullptr)
{
    return writeJsonFile(filePath, QJsonDocument(jsonObj), errStr);
}


} // namespace TaoCommon
