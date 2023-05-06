#include "ThreadPool.h"

#include <QThreadPool>
namespace TaoCommon
{
ThreadObject::ThreadObject(const WorkCallback& work)
	: m_workCall(work)
{
}
void ThreadObject::run()
{
	bool ok = m_workCall();
	emit readyResult(ok);
}
// workCall in sub thread, resultCall in main thread
void ThreadPool::work(const WorkCallback& workCall, const WorkResultCallback& resultCall)
{
	ThreadObject* obj = new ThreadObject(workCall);
	obj->setAutoDelete(true);
	connect(obj, &ThreadObject::readyResult, this, resultCall);
	QThreadPool::globalInstance()->start(obj);
}
} // namespace TaoCommon
