#!/bin/bash

rm logcat.txt
adb shell logcat -c
adb shell logcat > logcat.txt
