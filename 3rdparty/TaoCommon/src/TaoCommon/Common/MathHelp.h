#pragma once
#include <cmath>
#include <QtGlobal>
#include <algorithm>
//inRange 检查  value 小于等于 max， 大于等于min

//inRange<T>通用模版函数
template<typename T>
static bool inRange(const T &value, const T &min, const T &max)
{
    if (min <= value && value <= max) {
        return true;
    }
    return false;
}
//inRange<double> 模版偏特化，遇到double时，使用std的浮点数比较代替 常规比较。规避精度误差
template<>
static bool inRange<double>(const double &value, const double &min, const double &max)
{
    if (std::isgreaterequal(value, min) && std::islessequal(value, max)) {
        return true;
    }
    return false;
}
//inRange<float> 模版偏特化，遇到float时，使用std的浮点数比较代替 常规比较。规避精度误差
template<>
static bool inRange<float>(const float &value, const float &min, const float &max)
{
    if (std::isgreaterequal(value, min) && std::islessequal(value, max)) {
        return true;
    }
    return false;
}
//clamp, 限制 value在 [min - Max]区间.
template<typename T>
static T clamp(const T &value, const T &min, const T &max)
{
    return std::max(min,std::min(value, max));
}
