#pragma once

// json 序列化
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>

#include <QVariant>
#include <QVariantList>
#include <QVariantMap>

///@brief 序列化. object to Json, object to Variant or VariantMap
#define JsonSerialize_Begin()                                                                                                                                  \
public:                                                                                                                                                        \
	operator QVariant() const                                                                                                                                  \
	{                                                                                                                                                          \
		return QVariant::fromValue(this->operator QVariantMap());                                                                                              \
	}                                                                                                                                                          \
	operator QJsonObject() const                                                                                                                               \
	{                                                                                                                                                          \
		return QJsonObject::fromVariantMap(this->operator QVariantMap());                                                                                      \
	}                                                                                                                                                          \
	operator QVariantMap() const                                                                                                                               \
	{                                                                                                                                                          \
		QVariantMap vmap;

#define JsonSerialize_End()                                                                                                                                    \
	return vmap;                                                                                                                                               \
	}

///@brief 序列化属性映射
#define JsonPureProperty(NAME) vmap.unite((QVariantMap)m_##NAME);

#define JsonProperty(NAME)                                                                                                                                     \
	vmap[#NAME] = QVariant::fromValue(m_##NAME);                                                                                                               \
	if (vmap.value(#NAME).isNull())                                                                                                                            \
		vmap.remove(#NAME);

#define JsonContainerProperty(NAME)                                                                                                                            \
	{                                                                                                                                                          \
		QVariantList lst;                                                                                                                                      \
		lst.reserve(m_##NAME.size());                                                                                                                          \
		for (const auto& t : m_##NAME)                                                                                                                         \
		{                                                                                                                                                      \
			lst << QVariant::fromValue(t);                                                                                                                     \
		}                                                                                                                                                      \
		vmap[#NAME] = lst;                                                                                                                                     \
	}

///@brief 反序列化 object from json
#define JsonDeserialize_Begin(class_name)                                                                                                                      \
public:                                                                                                                                                        \
	class_name(const QJsonObject& other)                                                                                                                       \
	{                                                                                                                                                          \
		QVariantMap vmap = other.toVariantMap();

#define JsonDeserialize_End() }

///@brief 部分反序列化
#define JsonPartialDeserialize_Begin(class_name)                                                                                                               \
public:                                                                                                                                                        \
	class_name& operator=(const QJsonObject& other)                                                                                                            \
	{                                                                                                                                                          \
		QVariantMap vmap = other.toVariantMap();

#define JsonPartialDeserialize_End()                                                                                                                           \
	return *this;                                                                                                                                              \
	}

#define JsonDeserializeContainerProperty(NAME)                                                                                                                 \
	if (vmap.value(#NAME).canConvert<QVariantList>())                                                                                                          \
	{                                                                                                                                                          \
		const auto& list = vmap.value(#NAME).value<QVariantList>();                                                                                            \
		m_##NAME.clear();                                                                                                                                      \
		m_##NAME.reserve(list.size());                                                                                                                         \
		for (const auto& v : list)                                                                                                                             \
		{                                                                                                                                                      \
			m_##NAME.push_back(v.value<decltype(m_##NAME)::value_type>());                                                                                     \
		}                                                                                                                                                      \
	}

#define JsonDeserializeProperty(NAME) m_##NAME = vmap.value(#NAME).value<decltype(m_##NAME)>();

/**
* Example:
*
class AppInfo : public QObject
{
	Q_OBJECT

	AUTO_PROPERTY(QString, appName, "")
	AUTO_PROPERTY(bool, splashShow, false)
	AUTO_PROPERTY(float, scale, 1.0f)
	AUTO_PROPERTY(double, ratio, 14.0 / 9.0)
	AUTO_PROPERTY(QStringList, customs, {})

	JsonSerialize_Begin()
		JsonProperty(appName)
		JsonProperty(splashShow)
		JsonProperty(scale)
		JsonProperty(ratio)
		JsonContainerProperty(customs)
	JsonSerialize_End()

	JsonDeserialize_Begin(AppInfo)
		JsonDeserializeProperty(appName)
		JsonDeserializeProperty(splashShow)
		JsonDeserializeProperty(scale)
		JsonDeserializeProperty(ratio)
		JsonDeserializeContainerProperty(customs)
	JsonDeserialize_End()


	JsonPartialDeserialize_Begin(AppInfo)
		JsonDeserializeProperty(appName)
		JsonDeserializeProperty(splashShow)
		JsonDeserializeProperty(scale)
		JsonDeserializeProperty(ratio)
		JsonDeserializeContainerProperty(customs)
	JsonPartialDeserialize_End()

public:
	explicit AppInfo(QObject *parent = nullptr);
	virtual ~AppInfo() override;
};

these MACOR will generate these function:

AppInfo(const QJsonobject &obj)
AppInfo &operator=(const QJsonobject &obj)

operator QJsonobject()
operator QVariantMap()
operator QVariant()

*/

/**
* then you can use it.
*
* 1. init AppInfo from Json by construct or operator=
*

*
*   QJsonObject obj;
*   AppInfo info = obj;
*
* 2. convert object to Json or VariantMap by operator
*
*
*   AppInfo info;
* ...
*   QJsonObject obj = info;
*   QVariant var = info;
*   QVariantMap map = info;
*
**/
