#!/bin/sh
./gradlew clean
./gradlew :app:assembleDebug
adb install -r app/build/outputs/apk/debug/app-debug.apk
adb shell am start com.android.demo/com.android.demo.MainActivity
