defineTest(minQtVersion) {
    maj = $$1
    min = $$2
    patch = $$3
    isEqual(QT_MAJOR_VERSION, $$maj) {
        isEqual(QT_MINOR_VERSION, $$min) {
            isEqual(QT_PATCH_VERSION, $$patch) {
                return(true)
            }
            greaterThan(QT_PATCH_VERSION, $$patch) {
                return(true)
            }
        }
        greaterThan(QT_MINOR_VERSION, $$min) {
            return(true)
        }
    }
    greaterThan(QT_MAJOR_VERSION, $$maj) {
        return(true)
    }
    return(false)
}

!minQtVersion(5, 9, 0) {
    error("TaoQuick minimum supported Qt5 version is 5.9.0")
}

TEMPLATE = subdirs

SUBDIRS += \
#    src \
    examples
CONFIG+= ordered

OTHER_FILES += *.md \
    LICENSE \
    _clang-format \
    .qmake.conf \
    .github/workflows/* \
    scripts/* \
    mkspecs/features/*
