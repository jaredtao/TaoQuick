#pragma once
#include "taocommonglobal.h"
#include "threadcommon.h"
#include <QObject>
#include <QRunnable>
namespace TaoCommon
{
    // 对Qt线程池的简单封装，适合一次性执行的任务。
    // 用法: ThreadPool::getInstance()->work(workCall, resultCall)
    // workCall是在新线程中执行的任务，resultCall是任务执行完成后，回到调用线程中用来处理执行结果。
    // 不支持任务取消、暂停。

    class ThreadObject
        : public QObject
        , public QRunnable
    {
        Q_OBJECT
    public:
        explicit ThreadObject(const WorkCallback& work);
        void run() override;
    signals:
        void readyResult(bool);

    private:
        WorkCallback m_workCall;
    };
    class TAO_API ThreadPool : public QObject
    {
        Q_OBJECT
    public:
        static ThreadPool* getInstance()
        {
            static ThreadPool poll;
            return &poll;
        }
        //workCall in sub thread, resultCall in main thread
        void work(const WorkCallback& workCall, const WorkResultCallback& resultCall);
    private:
        ThreadPool() {}
    };
} // namespace TaoCommon
