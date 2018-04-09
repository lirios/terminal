#!/bin/bash

set -e

source /usr/local/share/liri-travis/functions

# Install packages
travis_start "install_packages"
msg "Install packages..."
sudo apt-get install -y desktop-file-utils appstream-util
travis_end "install_packages"

# Install artifacts
travis_start "artifacts"
msg "Install artifacts..."
for name in qbs-shared fluid qtgsettings; do
    /usr/local/bin/liri-download-artifacts $TRAVIS_BRANCH ${name}-artifacts.tar.gz
done
travis_end "artifacts"

# Configure qbs
travis_start "qbs_setup"
msg "Setup qbs..."
qbs setup-toolchains --detect
qbs setup-qt $(which qmake) travis-qt5
qbs config profiles.travis-qt5.baseProfile $CC
travis_end "qbs_setup"

# Build
travis_start "build"
msg "Build..."
dbus-run-session -- \
xvfb-run -a -s "-screen 0 800x600x24" \
qbs -d build -j $(nproc) --all-products profile:travis-qt5 \
    modules.lirideployment.prefix:/usr \
    modules.lirideployment.libDir:/usr/lib/x86_64-linux-gnu \
    modules.lirideployment.qmlDir:/usr/lib/x86_64-linux-gnu/qt5/qml \
    modules.lirideployment.pluginsDir:/usr/lib/x86_64-linux-gnu/qt5/plugins
travis_end "build"

# Validate desktop file and appdata
for filename in $(find . -type f -name "*.desktop"); do
    desktop-file-validate $filename
done
for filename in $(find . -type f -name "*.appdata.xml"); do
    appstream-util validate-relax --nonet $filename
done
