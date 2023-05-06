#pragma once
#include "TaoCommonGlobal.h"
#include "ThreadCommon.h"
#include <QMap>
#include <QThread>
namespace TaoCommon
{
// 对Qt Worker-Controller 线程模型的简单封装，适合精确控制的任务。
// 用法: ThreadController::getInstance()->work(workCall, resultCall)
// workCall是在新线程中执行的任务，resultCall是任务执行完成后，回到调用线程中用来处理执行结果。
// work函数返回值为任务id。
// 取消任务用ThreadController::getInstance()->cancle(id)函数。
class ThreadWorker : public QObject
{
	Q_OBJECT
public:
	ThreadWorker(uint64_t id, const WorkCallback& workCall, QObject* parent = nullptr)
		: QObject(parent)
		, m_id(id)
		, m_workCall(workCall)
	{
	}

signals:
	void workFinished(bool, uint64_t);
public slots:
	void doWork()
	{
		bool ret = m_workCall();
		emit workFinished(ret, m_id);
	}

private:
	const uint64_t m_id;
	WorkCallback   m_workCall;
};
class TAO_API ThreadController : public QObject
{
	Q_OBJECT
public:
	static ThreadController* getInstance()
	{
		static ThreadController controller;
		return &controller;
	}

	~ThreadController()
	{
		for (const auto& k : m_threadMap.keys())
		{
			if (m_threadMap.value(k)->isRunning())
			{
				m_threadMap.value(k)->quit();
				m_threadMap.value(k)->wait();
			}
		}
		qDeleteAll(m_threadMap);
		m_threadMap.clear();
		m_resultCallback.clear();
	}
	uint64_t work(const WorkCallback& workCall, const WorkResultCallback& resultCall)
	{
		QThread* thread = new QThread;
		m_rollId++;
		ThreadWorker* obj		   = new ThreadWorker(m_rollId, workCall);
		m_threadMap[m_rollId]	   = thread;
		m_resultCallback[m_rollId] = resultCall;
		obj->moveToThread(thread);

		connect(thread, &QThread::finished, obj, &QObject::deleteLater);
		connect(thread, &QThread::started, obj, &ThreadWorker::doWork);
		connect(obj, &ThreadWorker::workFinished, this, &ThreadController::onWorkFinished, Qt::QueuedConnection);
		thread->start();
		return m_rollId;
	}
	void cancle(uint64_t id)
	{
		auto it = m_threadMap.find(id);
		if (it != m_threadMap.end())
		{
			if ((*it)->isRunning())
			{
				(*it)->terminate();
			}
		}
		m_resultCallback.remove(id);
	}
	void quit(uint64_t id)
	{
		auto it = m_threadMap.find(id);
		if (it != m_threadMap.end())
		{
			if ((*it)->isRunning())
			{
				(*it)->quit();
				(*it)->wait();
				(*it)->deleteLater();
			}
		}
		m_resultCallback.remove(id);
	}
	QList<uint64_t> getAllWorkId() const
	{
		return m_threadMap.keys();
	}
protected slots:
	void onWorkFinished(bool ok, uint64_t id)
	{
		auto it = m_threadMap.find(id);
		if (it != m_threadMap.end())
		{
			if ((*it)->isRunning())
			{
				(*it)->quit();
				(*it)->wait();
				(*it)->deleteLater();
			}
			m_threadMap.remove(id);
		}
		auto caller = m_resultCallback.find(id);
		if (caller != m_resultCallback.end())
		{
			(*caller)(ok);
			m_resultCallback.remove(id);
		}
	}

protected:
	ThreadController(QObject* parent = nullptr)
		: QObject(parent)
	{
	}

private:
	uint64_t						   m_rollId = 0;
	QMap<uint64_t, QThread*>		   m_threadMap;
	QMap<uint64_t, WorkResultCallback> m_resultCallback;
};
} // namespace TaoCommon
