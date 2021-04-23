#pragma once
#include <QObject>
#include <QtGlobal>

template<typename T>
struct Compare;

template<typename T>
struct Compare
{
    static bool isEqual(const T &t1, const T &t2) { return t1 == t2; }
};
template<>
struct Compare<float>
{
    static bool isEqual(float f1, float f2) { return qFuzzyCompare(f1, f2); }
};
template<>
struct Compare<double>
{
    static bool isEqual(double d1, double d2) { return qFuzzyCompare(d1, d2); }
};
//member variant
#define PROP_MEM(T, NAME, InitValue) T m_##NAME = InitValue;

//get method
#define PROP_GET(T, NAME)                                                                                                                                      \
    const T &NAME() const { return m_##NAME; }
//change signal
#define PROP_CHANGE(T, NAME) Q_SIGNAL void NAME##Changed(const T &value);

//set method
#define PROP_SET(T, NAME)                                                                                                                                      \
    void set_##NAME(const T &value)                                                                                                                            \
    {                                                                                                                                                          \
        if (Compare<T>::isEqual(m_##NAME, value))                                                                                                              \
            return;                                                                                                                                            \
        m_##NAME = value;                                                                                                                                      \
        emit NAME##Changed(value);                                                                                                                             \
    }
//ReadOnly property
#define READONLY_PROPERTY(T, NAME, InitValue)                                                                                                                  \
private:                                                                                                                                                       \
    Q_PROPERTY(T NAME READ NAME CONSTANT)                                                                                                                      \
public:                                                                                                                                                        \
    PROP_GET(T, NAME)                                                                                                                                          \
private:                                                                                                                                                       \
    PROP_MEM(T, NAME, InitValue)

//Readable property
#define READ_PROPERTY(T, NAME, InitValue)                                                                                                                      \
private:                                                                                                                                                       \
    Q_PROPERTY(T NAME READ NAME NOTIFY NAME##Changed)                                                                                                          \
public:                                                                                                                                                        \
    PROP_GET(T, NAME)                                                                                                                                          \
    PROP_SET(T, NAME)                                                                                                                                          \
    PROP_CHANGE(T, NAME)                                                                                                                                       \
private:                                                                                                                                                       \
    PROP_MEM(T, NAME, InitValue)
//Read Write property
#define AUTO_PROPERTY(T, NAME, InitValue)                                                                                                                      \
private:                                                                                                                                                       \
    Q_PROPERTY(T NAME READ NAME WRITE set_##NAME NOTIFY NAME##Changed)                                                                                         \
public:                                                                                                                                                        \
    PROP_GET(T, NAME)                                                                                                                                          \
    Q_SLOT PROP_SET(T, NAME)                                                                                                                                           \
    PROP_CHANGE(T, NAME)                                                                                                                                       \
private:                                                                                                                                                       \
    PROP_MEM(T, NAME, InitValue)

/**
* Example:
*
class AppInfo : public QObject
{
    Q_OBJECT

AUTO_PROPERTY(QString, appName, "")
AUTO_PROPERTY(QString, descript, "")
AUTO_PROPERTY(QString, compilerVendor, "")
AUTO_PROPERTY(bool, splashShow, false)
AUTO_PROPERTY(float, scale, 1.0f)
AUTO_PROPERTY(double, ratio, 14.0 / 9.0)
AUTO_PROPERTY(QStringList, customs, {})
public:
explicit AppInfo(QObject *parent = nullptr);
virtual ~AppInfo() override;
public:

};


*/
