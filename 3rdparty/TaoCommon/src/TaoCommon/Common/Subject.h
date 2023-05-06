#pragma once
#include <algorithm>
#include <map>
#include <vector>
namespace TaoCommon
{
// 观察者模式，Subject-Observer。
//  Subject 事件或消息的主体。模板参数为观察者类型
template <typename ObserverType>
class Subject
{
public:
	virtual ~Subject()
	{
		m_obsList.clear();
	}
	// 订阅
	void subscibe(ObserverType* obs)
	{
		auto itor = std::find(m_obsList.begin(), m_obsList.end(), obs);
		if (m_obsList.end() == itor)
		{
			m_obsList.push_back(obs);
		}
	}
	// 取消订阅
	void unSubscibe(ObserverType* obs)
	{
		m_obsList.erase(std::remove(m_obsList.begin(), m_obsList.end(), obs));
	}
	// 发布。这里的模板参数为函数类型。
	template <typename FuncType>
	void publish(FuncType func)
	{
		for (auto obs : m_obsList)
		{
			// 调用回调函数，将obs作为第一个参数传递
			func(obs);
		}
	}
	// 发布。支持过滤观察者。通常用在 观察者触发消息发布时，过滤观察者自己。
	template <typename FuncType>
	void publish(FuncType func, ObserverType* exceptObs)
	{
		for (auto obs : m_obsList)
		{
			// 调用回调函数，将obs作为第一个参数传递
			if (obs != exceptObs)
			{
				func(obs);
			}
		}
	}

private:
	std::vector<ObserverType*> m_obsList;
};

// 优先级观察者模式，Subject-Observer。
template <typename ObserverType>
class LevelSubject
{
public:
	virtual ~LevelSubject()
	{
		m_obsMap.clear();
	}
	// 订阅
	void subscibe(ObserverType* obs, uint32_t level)
	{
		auto& vec  = m_obsMap[level];
		auto  itor = std::find(vec.begin(), vec.end(), obs);
		if (vec.end() == itor)
		{
			vec.push_back(obs);
		}
	}
	// 取消订阅
	void unSubscibe(ObserverType* obs)
	{
		for (auto& obsPair : m_obsMap)
		{
			obsPair.second.erase(std::remove(obsPair.second.begin(), obsPair.second.end(), obs));
		}
	}
	// 发布。这里的模板参数为函数类型。
	template <typename FuncType>
	void publish(FuncType func)
	{
		for (const auto& obsPair : m_obsMap)
		{
			for (const auto& obs : obsPair.second)
			{
				func(obs);
			}
		}
	}
	template <typename FuncType>
	void publish(FuncType func, ObserverType* exceptObs)
	{
		for (const auto& obsPair : m_obsMap)
		{
			for (const auto& obs : obsPair.second)
			{
				if (obs != exceptObs)
				{
					func(obs);
				}
			}
		}
	}

private:
	std::map<uint32_t, std::vector<ObserverType*>> m_obsMap;
};
} // namespace TaoCommon
