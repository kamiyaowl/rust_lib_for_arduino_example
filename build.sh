#!/bin/sh

LIB_NAME="rust_lib_for_arduino_example"
DST_DIR="./$LIB_NAME"

echo "create destination directory"
if [ -d "$DST_DIR" ]; then rm -Rf $DST_DIR; fi
mkdir $DST_DIR
mkdir "$DST_DIR/src"
mkdir "$DST_DIR/src/cortex-m0"
mkdir "$DST_DIR/src/cortex-m0plus"
mkdir "$DST_DIR/src/cortex-m3"
mkdir "$DST_DIR/src/cortex-m4"

echo "copy library.properties"
cp "./library.properties" "$DST_DIR/"

echo "build library"
cargo build --release --target thumbv6m-none-eabi
cargo build --release --target thumbv7m-none-eabi
cargo build --release --target thumbv7em-none-eabi
cargo build --release --target thumbv7em-none-eabihf

echo "copy target/<target arch>/release/lib$LIB_NAME.a"
cp "./target/thumbv6m-none-eabi/release/lib$LIB_NAME.a"    "$DST_DIR/src/cortex-m0/"
cp "./target/thumbv6m-none-eabi/release/lib$LIB_NAME.a"    "$DST_DIR/src/cortex-m0plus/"
cp "./target/thumbv7m-none-eabi/release/lib$LIB_NAME.a"    "$DST_DIR/src/cortex-m3/"
cp "./target/thumbv7em-none-eabihf/release/lib$LIB_NAME.a" "$DST_DIR/src/cortex-m4/" # for Cortex-M4F/M7F
cp "./target/thumbv7em-none-eabihf/release/lib$LIB_NAME.a" "$DST_DIR/src/cortex-m7/" # for Cortex-M4F/M7F
# cp "./target/thumbv7em-none-eabi/release/lib$LIB_NAME.a" "$DST_DIR/src/cortex-m4/" # for Cortex-M4/M7

echo "copy $LIB_NAME.h"
cp "./$LIB_NAME.h" "$DST_DIR/src/"

echo "compress $DST_DIR"
if [ -d "./$LIB_NAME.zip" ]; then rm -Rf "./$LIB_NAME.zip"; fi
zip -r "./$LIB_NAME.zip" "$DST_DIR" 

echo "Done."