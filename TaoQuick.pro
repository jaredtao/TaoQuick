lessThan(QT_MAJOR_VERSION, 5): lessThan(QT_MINOR_VERSION, 9) {
    error("current Qt version $$QT_VERSION, this project need grather than 5.9.0")
}

TEMPLATE = subdirs

SUBDIRS += \
#    src \
    examples
CONFIG+= ordered

OTHER_FILES += *.md \
    LICENSE \
    .clang-format \
    .qmake.conf \
    .github/workflows/* \
    mkspecs/features/*
