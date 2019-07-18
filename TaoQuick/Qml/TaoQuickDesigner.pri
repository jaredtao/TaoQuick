taoquick_designer.files = $$PWD/designer/TaoQuick.metainfo
taoquick_designer.path = $$[QT_INSTALL_QML]/$${uri}/designer

toaquick_qmldir.files = $$PWD/qmldir
toaquick_qmldir.path = $$[QT_INSTALL_QML]/$${uri}

taoquick_qml_buttons.files = $$PWD/BasicComponent/Button/*.qml
taoquick_qml_buttons.path = $$[QT_INSTALL_QML]/$${uri}/BasicComponent/Button

taoquick_qml_mouse.files = $$PWD/BasicComponent/Mouse/*.qml
taoquick_qml_mouse.path = $$[QT_INSTALL_QML]/$${uri}/BasicComponent/Mouse

taoquick_qml_others.files = $$PWD/BasicComponent/Others/*.qml
taoquick_qml_others.path = $$[QT_INSTALL_QML]/$${uri}/BasicComponent/Others

taoquick_qml_progress.files = $$PWD/BasicComponent/Progress/*.qml
taoquick_qml_progress.path = $$[QT_INSTALL_QML]/$${uri}/BasicComponent/Progress

taoquick_degisner_images.files = $$PWD/designer/images/*.png
taoquick_degisner_images.path = $$[QT_INSTALL_QML]/$${uri}/designer/images

INSTALLS  += taoquick_designer toaquick_qmldir taoquick_qml_buttons taoquick_qml_mouse taoquick_qml_others taoquick_qml_progress taoquick_degisner_images
