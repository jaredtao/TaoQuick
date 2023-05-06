#pragma once
#include <QObject>
#include <QtGlobal>

// 比较器的 声明
template <typename T>
struct Compare;

// 通用比较器
template <typename T>
struct Compare
{
	static bool isEqual(const T& t1, const T& t2)
	{
		return t1 == t2;
	}
};
// float 比较器。
template <>
struct Compare<float>
{
	static bool isEqual(float f1, float f2)
	{
		return qFuzzyCompare(f1, f2);
	}
};
// double 比较器。
template <>
struct Compare<double>
{
	static bool isEqual(double d1, double d2)
	{
		return qFuzzyCompare(d1, d2);
	}
};
//**********************************普通成员及函数**********************************
// 成员变量
#define PROP_MEM(T, NAME, InitValue) T m_##NAME = InitValue;

// 普通 get 函数
#define MEM_GET(T, NAME)                                                                                                                                       \
	const T& NAME() const                                                                                                                                      \
	{                                                                                                                                                          \
		return m_##NAME;                                                                                                                                       \
	}

// 普通 set 函数
#define MEM_SET(T, NAME)                                                                                                                                       \
	void set_##NAME(const T& value)                                                                                                                            \
	{                                                                                                                                                          \
		m_##NAME = value;                                                                                                                                      \
	}

// 普通 可读可写 成员及函数
#define AUTO_MEM(T, NAME, InitValue)                                                                                                                           \
public:                                                                                                                                                        \
	MEM_GET(T, NAME)                                                                                                                                           \
	MEM_SET(T, NAME)                                                                                                                                           \
private:                                                                                                                                                       \
	PROP_MEM(T, NAME, InitValue)

//**********************************QObject 属性**********************************

// 属性 change 信号
#define PROP_CHANGE(T, NAME) Q_SIGNAL void NAME##Changed(const T& value);

// 属性 get 函数 (和普通get没区别)
#define PROP_GET(T, NAME) MEM_GET(T, NAME)

// 属性 set 函数 (比普通set 多 changeCheck，change 时发信号. check 时处理 float 和 double 数据的精度)
#define PROP_SET(T, NAME)                                                                                                                                      \
	void set_##NAME(const T& value)                                                                                                                            \
	{                                                                                                                                                          \
		if (Compare<T>::isEqual(m_##NAME, value))                                                                                                              \
			return;                                                                                                                                            \
		m_##NAME = value;                                                                                                                                      \
		emit NAME##Changed(value);                                                                                                                             \
	}

// 只读属性，外部不能改
#define READONLY_PROPERTY(T, NAME, InitValue)                                                                                                                  \
private:                                                                                                                                                       \
	Q_PROPERTY(T NAME READ NAME CONSTANT)                                                                                                                      \
public:                                                                                                                                                        \
	PROP_GET(T, NAME)                                                                                                                                          \
private:                                                                                                                                                       \
	PROP_MEM(T, NAME, InitValue)

// 可读属性，比只读属性 多一个 属性set函数。
#define READ_PROPERTY(T, NAME, InitValue)                                                                                                                      \
private:                                                                                                                                                       \
	Q_PROPERTY(T NAME READ NAME NOTIFY NAME##Changed)                                                                                                          \
public:                                                                                                                                                        \
	PROP_GET(T, NAME)                                                                                                                                          \
	PROP_SET(T, NAME)                                                                                                                                          \
	PROP_CHANGE(T, NAME)                                                                                                                                       \
private:                                                                                                                                                       \
	PROP_MEM(T, NAME, InitValue)

// 可读可写 属性。属性set函数 提升为 slot ，可被 invok / qml 调用
#define AUTO_PROPERTY(T, NAME, InitValue)                                                                                                                      \
private:                                                                                                                                                       \
	Q_PROPERTY(T NAME READ NAME WRITE set_##NAME NOTIFY NAME##Changed)                                                                                         \
public:                                                                                                                                                        \
	PROP_GET(T, NAME);                                                                                                                                         \
	Q_SLOT PROP_SET(T, NAME);                                                                                                                                  \
	PROP_CHANGE(T, NAME);                                                                                                                                      \
                                                                                                                                                               \
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

//**********************************QObject 属性 二进制兼容版, 头文件声明 与 源文件定义 分离**********************************

// 属性 get 函数声明
#define PROP_GET_DECL(T, NAME) const T& NAME() const;

// 属性 set 函数声明
#define PROP_SET_DECL(T, NAME) void set_##NAME(const T& value);

// d 指针类型名
#define D_TYPE PrivateData

// d 指针成员变量名
#define D_NAME dPtr

// d 指针的声明
#define D_DECL                                                                                                                                                 \
private:                                                                                                                                                       \
	struct D_TYPE;                                                                                                                                             \
	D_TYPE* D_NAME = nullptr;

// d 指针的定义
#define D_IMPL(ClassName) struct ClassName::D_TYPE

// d 类的成员
#define D_MEM(T, NAME, InitValue) PROP_MEM(T, NAME, InitValue)

// 属性 get 函数定义
#define PROP_GET_IMPL(ClasName, T, NAME)                                                                                                                       \
	const T& ClasName::NAME() const                                                                                                                            \
	{                                                                                                                                                          \
		return D_NAME->m_##NAME;                                                                                                                               \
	}
// 属性 set 函数定义
#define PROP_SET_IMPL(ClasName, T, NAME)                                                                                                                       \
	void ClasName::set_##NAME(const T& value)                                                                                                                  \
	{                                                                                                                                                          \
		if (Compare<T>::isEqual(D_NAME->m_##NAME, value))                                                                                                      \
			return;                                                                                                                                            \
		D_NAME->m_##NAME = value;                                                                                                                              \
		emit NAME##Changed(value);                                                                                                                             \
	}

// 可读可写 属性声明。
#define AUTO_PROPERTY_DECL(T, NAME)                                                                                                                            \
private:                                                                                                                                                       \
	Q_PROPERTY(T NAME READ NAME WRITE set_##NAME NOTIFY NAME##Changed)                                                                                         \
public:                                                                                                                                                        \
	PROP_GET_DECL(T, NAME);                                                                                                                                    \
public slots:                                                                                                                                                  \
	PROP_SET_DECL(T, NAME);                                                                                                                                    \
signals:                                                                                                                                                       \
	PROP_CHANGE(T, NAME)

// 可读可写 属性定义。
#define AUTO_PROPERTY_IMPL(ClassName, T, NAME)                                                                                                                 \
	PROP_GET_IMPL(ClassName, T, NAME)                                                                                                                          \
	PROP_SET_IMPL(ClassName, T, NAME)

/**
* Example:
*

//AppInfo.h
class AppInfo : public QObject
{
	Q_OBJECT

	AUTO_PROPERTY_DECL(QString, appName, "")
	AUTO_PROPERTY_DECL(QString, descript, "")
	AUTO_PROPERTY_DECL(QString, compilerVendor, "")
	AUTO_PROPERTY_DECL(bool, splashShow, false)
	AUTO_PROPERTY_DECL(float, scale, 1.0f)
	AUTO_PROPERTY_DECL(double, ratio, 14.0 / 9.0)
	AUTO_PROPERTY_DECL(QStringList, customs, {})
public:
	explicit AppInfo(QObject *parent = nullptr);
	virtual ~AppInfo() override;
private:
	D_DECL;
};


//AppInfo.cpp

D_IMPL(AppInfo)
{
	D_MEM(QString, appName, "")
	D_MEM(QString, descript, "")
	D_MEM(QString, compilerVendor, "")
	D_MEM(bool, splashShow, false)
	D_MEM(float, scale, 1.0f)
	D_MEM(double, ratio, 14.0 / 9.0)
	D_MEM(QStringList, customs, {})

};
AUTO_PROPERTY_IMPL(AppInfo, QString, appName)
AUTO_PROPERTY_IMPL(AppInfo, QString, descript)
AUTO_PROPERTY_IMPL(AppInfo, QString, compilerVendor)
AUTO_PROPERTY_IMPL(AppInfo, bool, splashShow)
AUTO_PROPERTY_IMPL(AppInfo, float, scale)
AUTO_PROPERTY_IMPL(AppInfo, double, ratio)
AUTO_PROPERTY_IMPL(AppInfo, QStringList, customs)

AppInfo::AppInfo(QObject *parent)
	: QObject(parent)
	, D_NAME(new D_TYPE)
{}
AppInfo::~AppInfo()
{
	delete D_NAME;
}

*/
