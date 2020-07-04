#pragma once
class QQmlContext;
class TaoObject {
public:
    virtual ~TaoObject() {}

public:

    virtual void init() = 0;

    virtual void uninit() = 0;

    virtual void beforeUiReady(QQmlContext* ctx) = 0;

    virtual void afterUiReady() = 0;
};
