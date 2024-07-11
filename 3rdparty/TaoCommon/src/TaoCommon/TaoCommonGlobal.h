#pragma once
#include <QtCore/QtGlobal>

#if !defined(BUILD_STATIC) && !defined(TaoCommon_NO_LIB)
#	if defined(TaoCommon_Library)
#		define TAO_API Q_DECL_EXPORT
#	else
#		define TAO_API Q_DECL_IMPORT
#	endif
#else
#	define TAO_API
#endif
