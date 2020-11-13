#pragma once
#include <QObject>

#define READ_PROPERTY(TYPE, NAME)                                                                                                                              \
private:                                                                                                                                                       \
    Q_PROPERTY(TYPE NAME READ NAME NOTIFY NAME##Changed)                                                                                                       \
public:                                                                                                                                                        \
    const TYPE &NAME() const                                                                                                                                   \
    {                                                                                                                                                          \
        return m_##NAME;                                                                                                                                       \
    }                                                                                                                                                          \
    Q_SIGNAL void NAME##Changed(const TYPE &value);                                                                                                            \
                                                                                                                                                               \
private:                                                                                                                                                       \
    TYPE m_##NAME;

#define READONLY_PROPERTY(TYPE, NAME)                                                                                                                          \
private:                                                                                                                                                       \
    Q_PROPERTY(TYPE NAME READ NAME CONSTANT)                                                                                                                   \
public:                                                                                                                                                        \
    const TYPE &NAME() const                                                                                                                                   \
    {                                                                                                                                                          \
        return m_##NAME;                                                                                                                                       \
    }                                                                                                                                                          \
                                                                                                                                                               \
private:                                                                                                                                                       \
    TYPE m_##NAME;

#define AUTO_PROPERTY(TYPE, NAME)                                                                                                                              \
private:                                                                                                                                                       \
    Q_PROPERTY(TYPE NAME READ NAME WRITE NAME NOTIFY NAME##Changed)                                                                                            \
public:                                                                                                                                                        \
    const TYPE &NAME() const                                                                                                                                   \
    {                                                                                                                                                          \
        return m_##NAME;                                                                                                                                       \
    }                                                                                                                                                          \
    void NAME(const TYPE &value)                                                                                                                               \
    {                                                                                                                                                          \
        if (m_##NAME == value)                                                                                                                                 \
            return;                                                                                                                                            \
        m_##NAME = value;                                                                                                                                      \
        emit NAME##Changed(value);                                                                                                                             \
    }                                                                                                                                                          \
    Q_SIGNAL void NAME##Changed(const TYPE &value);                                                                                                            \
                                                                                                                                                               \
private:                                                                                                                                                       \
    TYPE m_##NAME;
