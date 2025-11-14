# 🎯 COPY-PASTE TERMINAL COMMANDS

## 🚀 COMPLETE ONE-SHOT SETUP (Copy this entire block)

```powershell
# Navigate to project
cd d:\MINESWEPPER\cursed_minesweeper

# Clean any previous builds
flutter clean

# Install dependencies
flutter pub get

# Check everything is OK
flutter doctor

# List connected devices
flutter devices
```

## 🎵 CREATE PLACEHOLDER AUDIO (If you have FFmpeg)

```powershell
# Create silent audio files for testing
cd d:\MINESWEPPER\cursed_minesweeper\assets\sounds

# Create one base file
ffmpeg -f lavfi -i anullsrc=r=22050:cl=mono -t 1 -c:a libvorbis placeholder.ogg

# Copy to all required names
Copy-Item placeholder.ogg explosion.ogg -Force
Copy-Item placeholder.ogg bach_gaya.ogg -Force
Copy-Item placeholder.ogg flag.ogg -Force
Copy-Item placeholder.ogg click.ogg -Force
Copy-Item placeholder.ogg win.ogg -Force
Copy-Item placeholder.ogg lose.ogg -Force

# Return to project root
cd ..\..

# Verify files exist
dir assets\sounds\*.ogg
```

## 🏃 RUN DEBUG BUILD (Fastest way to test)

```powershell
# Run on connected device (make sure device is connected first!)
flutter run -d <device-id>

# OR to see device IDs:
flutter devices
# Then pick one and run:
flutter run -d emulator-5554
```

## 🏃 RUN RELEASE BUILD (Better performance)

```powershell
# For low-spec devices, use release mode
flutter run --release
```

## 📱 BUILD & INSTALL DEBUG APK

```powershell
# Build debug APK
flutter build apk --debug

# Install on connected device
adb install -r build\app\outputs\flutter-apk\app-debug.apk

# Launch the app
adb shell am start -n com.example.cursed_minesweeper/.MainActivity
```

## 📱 BUILD & INSTALL RELEASE APK (Unsigned)

```powershell
# Build release APK
flutter build apk --release

# Install on connected device
adb install -r build\app\outputs\flutter-apk\app-release.apk

# Launch the app
adb shell am start -n com.example.cursed_minesweeper/.MainActivity
```

## 🔐 ONE-TIME KEYSTORE SETUP

```powershell
# Generate keystore (DO THIS ONCE!)
keytool -genkey -v -keystore $env:USERPROFILE\cursed_minesweeper_keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias cursedkey

# Follow the prompts and SAVE YOUR PASSWORDS!

# Then create key.properties file:
@"
storePassword=YOUR_PASSWORD_HERE
keyPassword=YOUR_PASSWORD_HERE
keyAlias=cursedkey
storeFile=$env:USERPROFILE\cursed_minesweeper_keystore.jks
"@ | Out-File -FilePath android\key.properties -Encoding UTF8
```

## 📦 BUILD SIGNED RELEASE APK

```powershell
# After keystore setup, build signed release
flutter build apk --release

# The APK will be signed automatically
# Install it:
adb install -r build\app\outputs\flutter-apk\app-release.apk
```

## 📦 BUILD SMALLER APKs (Split by architecture)

```powershell
# Build separate APKs for each CPU architecture
flutter build apk --split-per-abi

# You'll get 3 APKs (~30% smaller each):
dir build\app\outputs\flutter-apk\app-*-release.apk

# Install the appropriate one for your device:
# Most modern phones use arm64-v8a
adb install -r build\app\outputs\flutter-apk\app-arm64-v8a-release.apk

# Older phones use armeabi-v7a
adb install -r build\app\outputs\flutter-apk\app-armeabi-v7a-release.apk
```

## 🧪 RUN TESTS

```powershell
# Run all unit tests
flutter test

# Run specific test file
flutter test test\game_logic_test.dart

# Run with coverage
flutter test --coverage
```

## 🔍 DEBUG & DIAGNOSTICS

```powershell
# Check for issues
flutter doctor -v

# Analyze code
flutter analyze

# Check APK size
dir build\app\outputs\flutter-apk\*.apk

# View detailed APK analysis
flutter build apk --analyze-size

# Clear build cache
flutter clean

# Get app logs from device
adb logcat | Select-String "flutter"
```

## 🔄 REBUILD AFTER CODE CHANGES

```powershell
# Quick rebuild (debug)
flutter build apk --debug
adb install -r build\app\outputs\flutter-apk\app-debug.apk

# OR for release
flutter build apk --release
adb install -r build\app\outputs\flutter-apk\app-release.apk
```

## 🎮 DEVICE MANAGEMENT

```powershell
# List all connected devices
adb devices

# Restart ADB if device not showing
adb kill-server
adb start-server
adb devices

# Install APK on specific device
adb -s <device-id> install -r build\app\outputs\flutter-apk\app-release.apk

# Uninstall app from device
adb uninstall com.example.cursed_minesweeper

# Check device info
adb shell getprop ro.product.model
adb shell getprop ro.build.version.release
```

## 📊 PERFORMANCE MONITORING

```powershell
# Profile performance
flutter run --profile

# Enable performance overlay
# (Shows FPS counter on device)
# Press 'P' in terminal while app is running

# Check memory usage
adb shell dumpsys meminfo com.example.cursed_minesweeper
```

## 🎵 AUDIO FILE MANAGEMENT

```powershell
# Check if audio files exist
dir assets\sounds\*.ogg

# Check file sizes
dir assets\sounds\*.ogg | ForEach-Object { "{0,-30} {1,10} KB" -f $_.Name, [math]::Round($_.Length/1KB, 2) }

# Convert MP3 to OGG (if you have FFmpeg)
cd assets\sounds
Get-ChildItem *.mp3 | ForEach-Object {
    ffmpeg -i $_.Name -c:a libvorbis -qscale:a 5 ($_.BaseName + ".ogg")
}
cd ..\..
```

## 🌐 PLAY STORE BUILD

```powershell
# Build App Bundle for Google Play Store
flutter build appbundle --release

# The bundle will be at:
# build\app\outputs\bundle\release\app-release.aab

# Check bundle size
dir build\app\outputs\bundle\release\*.aab
```

## 🚨 EMERGENCY FIXES

```powershell
# If everything breaks, run this:
cd d:\MINESWEPPER\cursed_minesweeper
flutter clean
flutter pub get
flutter pub upgrade
flutter doctor
flutter build apk --debug
adb install -r build\app\outputs\flutter-apk\app-debug.apk
```

## 📱 TESTING ON MULTIPLE DEVICES

```powershell
# See all devices
flutter devices

# Run on specific device
flutter run -d <device-id>

# Install on all connected devices
adb devices | Select-String "device$" | ForEach-Object {
    $deviceId = $_.ToString().Split()[0]
    adb -s $deviceId install -r build\app\outputs\flutter-apk\app-release.apk
}
```

## 💾 BACKUP YOUR WORK

```powershell
# Archive the project (without build artifacts)
Compress-Archive -Path d:\MINESWEPPER\cursed_minesweeper\* -DestinationPath d:\MINESWEPPER\cursed_minesweeper_backup_$(Get-Date -Format 'yyyyMMdd').zip -CompressionLevel Optimal

# Backup just the source code
Compress-Archive -Path d:\MINESWEPPER\cursed_minesweeper\lib, d:\MINESWEPPER\cursed_minesweeper\pubspec.yaml -DestinationPath d:\MINESWEPPER\cursed_minesweeper_src_$(Get-Date -Format 'yyyyMMdd').zip
```

---

## 🎯 RECOMMENDED WORKFLOW FOR LOW-SPEC LAPTOP

```powershell
# 1. One-time setup
cd d:\MINESWEPPER\cursed_minesweeper
flutter pub get

# 2. Add audio files (see QUICKSTART.md)

# 3. Build release mode (much faster)
flutter build apk --release

# 4. Install and test
adb install -r build\app\outputs\flutter-apk\app-release.apk

# 5. After making code changes:
flutter build apk --release
adb install -r build\app\outputs\flutter-apk\app-release.apk

# Repeat step 5 for each change
```

---

## ✅ VERIFICATION COMMANDS

```powershell
# Verify everything is ready
cd d:\MINESWEPPER\cursed_minesweeper
flutter doctor
flutter pub get
dir assets\sounds\*.ogg
flutter devices

# If all above succeed, you're ready to build!
```

---

## 🎊 FINAL ONE-SHOT BUILD & RUN

Copy and paste this ENTIRE block after adding audio files:

```powershell
cd d:\MINESWEPPER\cursed_minesweeper; `
flutter clean; `
flutter pub get; `
flutter build apk --debug; `
adb install -r build\app\outputs\flutter-apk\app-debug.apk; `
adb shell am start -n com.example.cursed_minesweeper/.MainActivity
```

This single command will:
1. Navigate to project
2. Clean old builds
3. Get dependencies
4. Build APK
5. Install on device
6. Launch the app

---

**Save this file for quick reference! All commands you need are here. 🚀**
