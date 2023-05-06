#pragma once
#include <QByteArray>
#include <QByteArrayList>
#include <QDataStream>
#include <QIODevice>
// 简易的封包、拆包。主要用在socket中传输连续的数据时，处理粘在一起的问题。
// 这段代码是经过很多实际项目验证的，可放心使用。
// 适用的场景很简单，就是前面4个字节是头部，表示数据的长度，紧跟着就是那么长的数据。头和数据，加起来就是一个包。

// 假定头部占一个uint32的长度
const int static headerLength = sizeof(quint32);

// 封包。 入参为数据，返回值是 数据前面加一个头. 这就是一个数据包了
static QByteArray pack(const QByteArray& data)
{
	QByteArray	header(headerLength, 0);
	QDataStream os(&header, QIODevice::WriteOnly);
	os << static_cast<quint32>(data.length());
	return header + data;
}
// 拆包。入参为连续的数据，返回值是拆出来的所有包列表
static QByteArrayList unpack(const QByteArray& data)
{
	QByteArrayList list;
	QDataStream	   inStream(data);
	quint32		   sum = data.size();
	quint32		   pos = 0;
	while (pos + headerLength < sum)
	{
		quint32 packageLen = 0;
		packageLen		   = 0;
		inStream >> packageLen;
		if (packageLen + headerLength > sum - pos)
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
