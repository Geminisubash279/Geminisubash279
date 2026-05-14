@echo off
set ZIPALIGN=C:\Users\GSAM-PC\AppData\Local\Android\Sdk\build-tools\36.0.0\zipalign.exe
set APKSIGNER=C:\Users\GSAM-PC\AppData\Local\Android\Sdk\build-tools\36.0.0\apksigner.bat
set APK=D:\React\Scheme\android\app\build\outputs\apk\release\app-release.apk

echo Installing...
adb install -r %APK%
echo Done!
