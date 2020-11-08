set(TargetName TaoQuickShow)


file(GLOB_RECURSE CURRENT_HEADERS  *.h *.hpp)

aux_source_directory(./Src SRC1)
aux_source_directory(./Src/DeviceAddTable SRC2)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick QuickControls2 REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick QuickControls2 REQUIRED)


add_executable(${TargetName}
      ${SRC1}
      ${SRC2}
      Qml.qrc
      Contents.qrc
)