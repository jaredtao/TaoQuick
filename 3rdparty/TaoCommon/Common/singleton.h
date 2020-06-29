#pragma once
namespace TaoCommon
{
    //单例模板
    template <typename T>
    class Singleton
    {
    public:
        static T &instance()
        {
            static T t;
            return t;
        }
        virtual ~Singleton() {}

        Singleton(const Singleton &) = delete;
        Singleton &operator=(const Singleton &) = delete;

    protected:
        Singleton() {}
    };
/*
使用示例：

定义:
class DataManager : public Singleton<DataManager>
{
    friend class Singleton<DataManager>;
public:
    void loadData();
protected:
    DataManager();

private:

};

调用:
    DataManager::instance().loadData();
*/

} // namespace TaoCommon
