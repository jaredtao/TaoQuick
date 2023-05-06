#pragma once
#include <QMetaType>
#include <functional>
namespace TaoCommon
{
using WorkCallback		 = std::function<bool()>;
using WorkResultCallback = std::function<void(bool)>;
} // namespace TaoCommon
Q_DECLARE_METATYPE(TaoCommon::WorkCallback);
Q_DECLARE_METATYPE(TaoCommon::WorkResultCallback);
