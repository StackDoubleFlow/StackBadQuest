#!/bin/bash

PREFIX=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64
LD=$PREFIX/bin/aarch64-linux-android24-clang
STRIP=$PREFIX/bin/aarch64-linux-android-strip

stack_bad src/main.sb
$LD -shared src/main.o extern/libmodloader.so extern/libbeatsaber-hook_2_2_5.so -o libstack_bad.so
$STRIP libstack_bad.so

adb push libstack_bad.so /sdcard/Android/data/com.beatgames.beatsaber/files/mods/libstack_bad.so
adb shell am force-stop com.beatgames.beatsaber
adb shell am start com.beatgames.beatsaber/com.unity3d.player.UnityPlayerActivity

adb logcat -c && adb logcat > test.log
