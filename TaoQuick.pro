TEMPLATE = subdirs
SUBDIRS += \
    TaoQuickDemo \
    TaoQuick

CONFIG += ordered

OTHER_FILES += README.md \
    Install.md \
    Preview-animation.md \
    Preview-normal.md \
    .clang-format \
    LICENSE \
    appveyor.yml \
    .travis.yml    

macos {
OTHER_FILES += \
    scripts/macos/install.sh \
    scripts/macos/build.sh \
    scripts/macos/deploy.sh
}

linux {
OTHER_FILES += \
    scripts/ubuntu/install.sh \
    scripts/ubuntu/build.sh \
    scripts/ubuntu/deploy.sh
}
