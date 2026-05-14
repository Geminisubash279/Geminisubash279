@echo off
echo =============================
echo  GS Thanga Maligai APK Build
echo =============================

echo Step 1: Generating JS Bundle...
node node_modules/react-native/cli.js bundle --platform android --dev false --entry-file index.js --bundle-output android/app/build/generated/assets/react/release/index.android.bundle --assets-dest android/app/build/generated/res/react/release --reset-cache

echo Step 2: Building Release APK...
cd android
gradlew assembleRelease
cd ..

echo Step 3: Injecting Bundle and Images...
node -e "const fs=require('fs');const path=require('path');const {execSync}=require('child_process');const densities=['drawable-mdpi','drawable-xhdpi','drawable-xxhdpi','drawable-xxxhdpi'];const resDir='android/app/build/generated/res/react/release';let files=[];densities.forEach(d=>{const dir=path.join(resDir,d);if(fs.existsSync(dir)){fs.readdirSync(dir).forEach(f=>{files.push({src:path.join(dir,f).replace(/\\\\/g,'/'),entry:'res/'+d+'/'+f});});}});let ps='Add-Type -Assembly System.IO.Compression.FileSystem;';ps+='$apk=\"D:/React/Scheme/android/app/build/outputs/apk/release/app-release.apk\";';ps+='$b=\"D:/React/Scheme/android/app/build/generated/assets/react/release/index.android.bundle\";';ps+='$z=[System.IO.Compression.ZipFile]::Open($apk,\"Update\");';ps+='$ex=$z.GetEntry(\"assets/index.android.bundle\"); if($ex){$ex.Delete()};';ps+='$e=$z.CreateEntry(\"assets/index.android.bundle\");';ps+='$s=[System.IO.File]::OpenRead($b);$d=$e.Open();$s.CopyTo($d);$s.Close();$d.Close();';files.forEach(f=>{ps+='$ex=$z.GetEntry(\"'+f.entry+'\"); if($ex){$ex.Delete()};$e=$z.CreateEntry(\"'+f.entry+'\");$s=[System.IO.File]::OpenRead(\"'+f.src+'\");$d=$e.Open();$s.CopyTo($d);$s.Close();$d.Close();';});ps+='$z.Dispose(); Write-Host \"Done\"';fs.writeFileSync('inject_all.ps1',ps);execSync('powershell -File inject_all.ps1',{stdio:'inherit'});fs.unlinkSync('inject_all.ps1');"

echo Step 4: Zipalign...
"C:\Users\GSAM-PC\AppData\Local\Android\Sdk\build-tools\36.0.0\zipalign.exe" -f -p 4 android\app\build\outputs\apk\release\app-release.apk android\app\build\outputs\apk\release\app-release-aligned.apk

echo Step 5: Sign APK...
"C:\Users\GSAM-PC\AppData\Local\Android\Sdk\build-tools\36.0.0\apksigner.bat" sign --ks android\app\my-release-key.keystore --ks-pass pass:123456 --key-pass pass:123456 --ks-key-alias my-key-alias --out android\app\build\outputs\apk\release\app-release-final.apk android\app\build\outputs\apk\release\app-release-aligned.apk

echo.
echo =============================
echo  APK Ready:
echo  android\app\build\outputs\apk\release\app-release-final.apk
echo =============================
pause
