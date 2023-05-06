#pragma once
#include <functional>
#include <map>
#include <memory>
#include <type_traits>
#include <typeindex>
#include <typeinfo>
#include <unordered_map>
namespace TaoCommon
{

// 对象存储器
template <typename Key, typename Value>
class ObjectMap
{
public:
	virtual ~ObjectMap()
	{
		clear();
	}
	void addObj(const Key& key, const Value& obj)
	{
		m_objMap[key] = obj;
	}
	bool removeObj(const Key& key)
	{
		return (0 != m_objMap.erase(key));
	}
	Value getObj(const Key& key) const
	{
		auto itor = m_objMap.find(key);
		if (itor == m_objMap.end())
		{
			return nullptr;
		}
		else
		{
			return itor->second;
		}
	}
	template <class CallbackType>
	void forEach(const CallbackType& callback) const
	{
		for (const auto& pair : m_objMap)
		{
			callback(pair.second.get());
		}
	}
	void clear()
	{
		m_objMap.clear();
	}

protected:
	std::unordered_map<Key, Value> m_objMap;
};
// 智能对象存储器。自动生成key，自动管理对象。
template <typename ObjectType>
class CObjectMap
{
public:
	virtual ~CObjectMap()
	{
		clear();
	}
	template <typename DeriveObjectType>
	DeriveObjectType* getObject() const
	{
		static_assert(std::is_base_of<ObjectType, DeriveObjectType>::value, "DeriveObjectType must be derive from ObjectType");

		auto objPtr = m_objMap.getObj(std::type_index(typeid(std::shared_ptr<DeriveObjectType>)));
		return std::static_pointer_cast<DeriveObjectType>(objPtr).get();
	}
	template <typename DeriveObjectType, typename... Args>
	void createObject(Args&... args)
	{
		static_assert(std::is_base_of<ObjectType, DeriveObjectType>::value, "DeriveObjectType must be derive from ObjectType");

		auto obj = std::make_shared<DeriveObjectType>(args...);
		m_objMap.addObj(std::type_index(typeid(obj)), std::static_pointer_cast<ObjectType>(obj));
	}
	template <typename DeriveObjectType>
	bool destroyObject()
	{
		static_assert(std::is_base_of<ObjectType, DeriveObjectType>::value, "DeriveObjectType must be derive from ObjectType");

		return m_objMap.removeObj(std::type_index(typeid(std::shared_ptr<DeriveObjectType>)));
	}
	void forEach(const std::function<void(ObjectType*)>& callback) const
	{
		m_objMap.forEach(callback);
	}
	void clear()
	{
		m_objMap.clear();
	}

protected:
	ObjectMap<std::type_index, std::shared_ptr<ObjectType>> m_objMap;
};
// 优先级对象存储器。自动生成key，自动管理对象。支持按优先级处理
template <typename ObjectType>
class CLevelObjectMap
{
public:
	virtual ~CLevelObjectMap()
	{
		clear();
	}
	template <typename DeriveObjectType>
	DeriveObjectType* getObject() const
	{
		static_assert(std::is_base_of<ObjectType, DeriveObjectType>::value, "DeriveObjectType must be derive from ObjectType");

		auto index = std::type_index(typeid(std::shared_ptr<DeriveObjectType>));

		for (const auto& mainPair : m_map)
		{
			const std::unordered_map<std::type_index, std::shared_ptr<ObjectType>>& subMap = mainPair.second;

			auto itor = subMap.find(index);
			if (itor != subMap.end())
			{
				return std::static_pointer_cast<DeriveObjectType>(itor->second).get();
			}
		}
		return nullptr;
	}
	template <typename DeriveObjectType, typename... Args>
	void createObject(uint32_t level, Args&&... args)
	{
		static_assert(std::is_base_of<ObjectType, DeriveObjectType>::value, "DeriveObjectType must be derive from ObjectType");

		auto obj								   = std::make_shared<DeriveObjectType>(args...);
		m_map[level][std::type_index(typeid(obj))] = std::static_pointer_cast<ObjectType>(obj);
	}
	template <typename DeriveObjectType>
	bool destroyObject()
	{
		static_assert(std::is_base_of<ObjectType, DeriveObjectType>::value, "DeriveObjectType must be derive from ObjectType");

		auto index = std::type_index(typeid(std::shared_ptr<DeriveObjectType>));
		for (auto& mainPair : m_map)
		{
			std::unordered_map<std::type_index, std::shared_ptr<ObjectType>>& subMap = mainPair.second;

			auto itor = subMap.find(index);
			if (itor != subMap.end())
			{
				auto retItor = subMap.erase(itor);
				return retItor != subMap.end();
			}
		}
		return false;
	}
	void forEach(const std::function<void(ObjectType*)>& callback) const
	{
		for (const auto& mainPair : m_map)
		{
			const std::unordered_map<std::type_index, std::shared_ptr<ObjectType>>& subMap = mainPair.second;
			for (const auto& subPair : subMap)
			{
				callback(subPair.second.get());
			}
		}
	}
	void clear()
	{
		m_map.clear();
	}

private:
	std::map<uint32_t, std::unordered_map<std::type_index, std::shared_ptr<ObjectType>>> m_map;
};
} // namespace TaoCommon
