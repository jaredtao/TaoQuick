lessThan(QT_MAJOR_VERSION, 5) {
    error("current Qt version $$QT_VERSION, this project need grather than 5.12.0")
} else: lessThan(QT_MINOR_VERSION, 12){
    error("current Qt version $$QT_VERSION, this project need grather than 5.12.0")
}

TEMPLATE = subdirs

SUBDIRS += \
    src

OTHER_FILES += *.md \
    LICENSE \
    .clang-format \
    .qmake.conf \
    .github/workflows/* \
    mkspecs/features/*
