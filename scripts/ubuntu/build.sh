#! /bin/bash
source /opt/qt512/bin/qt512-env.sh 
qmake 
make -j$(nproc)