#pragma once
#include <QByteArray>
#include <QByteArrayList>
#include <QDataStream>

const int static headerLength = sizeof(quint32);

static QByteArray pack(const QByteArray &data)
{
    QByteArray header(headerLength, 0);
    QDataStream os(&header, QIODevice::WriteOnly);
    os << static_cast<quint32>(data.length());
    return header + data;
}
static QByteArrayList unpack(const QByteArray &data)
{
    QByteArrayList list;
    QDataStream inStream(data);
    quint32 sum = data.size();
    quint32 pos = 0;
    quint32 packageLen = 0;
    while (pos + headerLength < sum)
    {
        packageLen = 0;
        inStream >> packageLen;
        if (packageLen <= 0 || packageLen + headerLength > sum - pos)
        {
            break;
        }
        QByteArray subPackage = data.mid(pos + headerLength, packageLen);
        inStream.skipRawData(packageLen);
        list.append(subPackage);
        pos += headerLength + packageLen;
    }
    return list;
}
