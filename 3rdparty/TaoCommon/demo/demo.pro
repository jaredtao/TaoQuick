TEMPLATE = subdirs

SUBDIRS += \
    CommonWithSource

qtHaveModule(TaoCommon): SUBDIRS += \
        ExampleLog \
        CommonWithModule
