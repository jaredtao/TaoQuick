#pragma once
#include "CIMCommDef.h"

//json 序列化
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonDocument>
#include <QVariant>
#include <QVariantList>
#include <QVariantMap>

///@brief 序列化
#define JsonSerialize_Begin()   \
public:                         \
    operator QVariant() const {                           \
        return QVariant::fromValue(this->operator QVariantMap());\
    }                           \
    operator QJsonObject() const {                           \
        return QJsonObject::fromVariantMap(this->operator QVariantMap());\
    }                           \
    operator QVariantMap() const {      \
        QVariantMap vmap;       

#define JsonSerialize_End() \
        return vmap;        \
    } 

///@brief 反序列化
#define JsonDeserialize_Begin(class_name) \
public:\
    class_name(const QJsonObject& other)\
    {\
        QVariantMap vmap = other.toVariantMap();

#define JsonDeserialize_End() \
    }

///@brief 部分反序列化
#define JsonPartialDeserialize_Begin(class_name)\
public:\
    class_name& operator=(const QJsonObject& other)\
    {\
        QVariantMap vmap = other.toVariantMap();

#define JsonPartialDeserialize_End()\
        return *this;\
    }\

///@brief 序列化属性映射
#define JsonPureProperty(val) \
    vmap.unite((QVariantMap)val);

#define JsonProperty(name, val, atom_type) \
    vmap[name] = QVariant::fromValue<atom_type>(val);\
    if(vmap[name].isNull()) vmap.remove(name);

#define JsonContainerProperty(name, val, atom_type)\
    {\
        QVariantList lst;\
        for(atom_type t : val)\
        {\
            lst << QVariant::fromValue<atom_type>(t);\
        }\
        vmap[name] = lst;\
    }\

#define JsonDeserializeContainerProperty(name, val, atom_type)\
    if(vmap[name].canConvert<QVariantList>())\
    {\
        QSequentialIterable iterable = vmap[name].value<QSequentialIterable>();\
        Q_FOREACH(const QVariant &v, iterable) \
        {\
            val.push_back(v.value<atom_type>());\
        }\
    }

#define JsonDeserializeProperty(name, val, type)\
    val = vmap[name].value<type>(); 