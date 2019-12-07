#pragma once

#define RELEASE_VER 1  // 0: beta version; 1: release version
#define RELEASE_DATE __DATE__ //yyyy-mm-dd; only used for RELEASE_VER=1

#define RELEASE_TIME __TIME__ //hh:mm:ss

#define RELEASE_VER_MAIN  TaoMAJ
#define RELEASE_VER_MAIN2 TaoMIN
#define RELEASE_VER_SUB  TaoPAT

#define VER_COMPANYNAME_STR        "JaredTao\0"

#define VER_FILEDESCRIPTION_STR    "TaoQuickDemo,未经授权不得商用,侵权必究\0"
#define VER_INTERNALNAME_STR        "jaredtao.github.io\0"
#define VER_LEGALCOPYRIGHT_STR      "Copyright(C)2019-2029 JaredTao\0"
#define VER_LEGALTRADEMARKS_STR    "JaredTao\0"
#define VER_ORIGINALFILENAME_STR    "TaoQuickDemo.exe\0"
#define VER_PRODUCTNAME_STR        "TaoQuickDemo\0"

// version number (string)
#define TOSTRING2(arg) #arg

#define TOSTRING(arg) TOSTRING2(arg)
#define RELEASE_VER_STR    TOSTRING(RELEASE_VER_MAIN) "." TOSTRING(RELEASE_VER_MAIN2) "." TOSTRING(RELEASE_VER_SUB)

