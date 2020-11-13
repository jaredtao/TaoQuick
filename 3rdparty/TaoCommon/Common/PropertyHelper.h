#pragma once
#include <QObject>
#include <QtGlobal>


template <typename T>
struct Compare;

template <typename T>
struct Compare
{
    static bool isEqual(const T &t1, const T &t2)
    {
        return t1 == t2;
    }
};
template<>
struct Compare<float>
{
    static bool isEqual(float f1, float f2)
    {
        return qFuzzyCompare(f1, f2);
    }
};
template<>
struct Compare<double>
{
    static bool isEqual(double d1, double d2)
    {
        return qFuzzyCompare(d1, d2);
    }
};

#define READ_PROPERTY(T, NAME, InitValue)                                                          \
private:                                                                                           \
    Q_PROPERTY(T NAME READ NAME NOTIFY NAME##Changed)                                              \
public:                                                                                            \
    const T &NAME() const { return m_##NAME; }                                                     \
    Q_SIGNAL void NAME##Changed(const T &value);                                                   \
                                                                                                   \
private:                                                                                           \
    T m_##NAME = InitValue;

#define READONLY_PROPERTY(T, NAME, InitValue)                                                      \
private:                                                                                           \
    Q_PROPERTY(T NAME READ NAME CONSTANT)                                                          \
public:                                                                                            \
    const T &NAME() const { return m_##NAME; }                                                     \
                                                                                                   \
private:                                                                                           \
    T m_##NAME = InitValue;

#define AUTO_PROPERTY(T, NAME, InitValue)                                                          \
private:                                                                                           \
    Q_PROPERTY(T NAME READ NAME WRITE set_##NAME NOTIFY NAME##Changed)                             \
public:                                                                                            \
    const T &NAME() const { return m_##NAME; }                                                     \
    Q_SLOT void set_##NAME(const T &value)                                                         \
    {                                                                                              \
        if (Compare<T>::isEqual(m_##NAME, value))                                                  \
            return;                                                                                \
        m_##NAME = value;                                                                          \
        emit NAME##Changed(value);                                                                 \
    }                                                                                              \
    Q_SIGNAL void NAME##Changed(const T &value);                                                   \
                                                                                                   \
private:                                                                                           \
    T m_##NAME = InitValue;
