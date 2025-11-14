# 🚀 ONE-SHOT SETUP & RUN GUIDE

Complete copy-paste commands to get Cursed Minesweeper running!

## ⚡ Prerequisites Check

```powershell
# Check Flutter
flutter doctor -v

# Check Java
java -version

# List connected devices
flutter devices
```

## 📦 Step 1: Install Dependencies

```powershell
cd d:\MINESWEPPER\cursed_minesweeper
flutter pub get
```

## 🎵 Step 2: Add Audio Files (REQUIRED!)

**The app WILL crash without audio files!**

You have two options:

### Option A: Use Placeholder Silent Audio (Quick Test)
If you have FFmpeg installed:
```powershell
cd assets\sounds
ffmpeg -f lavfi -i anullsrc=r=22050:cl=mono -t 1 -c:a libvorbis explosion.ogg
Copy-Item explosion.ogg bach_gaya.ogg
Copy-Item explosion.ogg flag.ogg
Copy-Item explosion.ogg click.ogg
Copy-Item explosion.ogg win.ogg
Copy-Item explosion.ogg lose.ogg
cd ..\..
```

### Option B: Add Real Audio Files
1. Download or create 6 sound files (MP3/OGG)
2. Place them in `assets\sounds\` with these EXACT names:
   - `explosion.ogg`
   - `bach_gaya.ogg`
   - `flag.ogg`
   - `click.ogg`
   - `win.ogg`
   - `lose.ogg`

See `assets\sounds\README.md` for safe sound sources!

## 🏃 Step 3: Run Debug Build

```powershell
# On connected phone/emulator
flutter run

# OR for better performance on low-spec laptop
flutter run --release
```

## 📱 Step 4: Build & Install APK

### Debug APK (Quick)
```powershell
flutter build apk --debug
adb install -r build\app\outputs\flutter-apk\app-debug.apk
```

### Release APK (Optimized, unsigned)
```powershell
flutter build apk --release
adb install -r build\app\outputs\flutter-apk\app-release.apk
```

## 🔐 Step 5: Signed Release Build (For Distribution)

### One-Time Keystore Setup
```powershell
# Generate keystore (do this ONCE)
keytool -genkey -v -keystore $env:USERPROFILE\cursed_minesweeper_keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias cursedkey

# Follow prompts and SAVE YOUR PASSWORDS!
```

### Create key.properties
Create `android\key.properties` with:
```properties
storePassword=YOUR_PASSWORD_HERE
keyPassword=YOUR_PASSWORD_HERE
keyAlias=cursedkey
storeFile=C:/Users/YourUsername/cursed_minesweeper_keystore.jks
```

### Update build.gradle
See `android\SIGNING_SETUP.md` for detailed instructions!

### Build Signed APK
```powershell
flutter build apk --release
```

## 🎮 All-In-One Quick Test

Copy-paste this entire block (after adding audio files):

```powershell
cd d:\MINESWEPPER\cursed_minesweeper
flutter clean
flutter pub get
flutter build apk --debug
adb install -r build\app\outputs\flutter-apk\app-debug.apk
adb shell am start -n com.example.cursed_minesweeper/.MainActivity
```

## 🐛 Troubleshooting

### No audio?
```powershell
# Check files exist
dir assets\sounds\*.ogg
```

### Build fails?
```powershell
flutter clean
flutter pub get
flutter doctor
```

### Out of memory during build?
Edit `android\gradle.properties`:
```properties
org.gradle.jvmargs=-Xmx2048m
```

### Device not detected?
```powershell
adb devices
# If none, enable USB debugging on phone
```

## 📊 Common Commands

```powershell
# Run tests
flutter test

# Check APK size
dir build\app\outputs\flutter-apk\*.apk

# Build separate APKs per architecture (smaller size)
flutter build apk --split-per-abi

# Build app bundle for Play Store
flutter build appbundle --release

# Clean build artifacts
flutter clean

# Analyze code
flutter analyze
```

## 🎯 Recommended Workflow for Low-Spec Laptop

```powershell
# 1. Initial setup
cd d:\MINESWEPPER\cursed_minesweeper
flutter pub get

# 2. Add audio files (see Step 2 above)

# 3. Build release mode (much faster than debug)
flutter build apk --release

# 4. Install and test
adb install -r build\app\outputs\flutter-apk\app-release.apk

# 5. Make changes to code, then rebuild
flutter build apk --release
adb install -r build\app\outputs\flutter-apk\app-release.apk
```

## 📏 Optimize APK Size

```powershell
# Split by CPU architecture
flutter build apk --split-per-abi

# Results in 3 smaller APKs:
# - app-armeabi-v7a-release.apk (for older phones)
# - app-arm64-v8a-release.apk (for modern phones)
# - app-x86_64-release.apk (for emulators)

# Each is ~30% smaller than universal APK
```

## ✅ Verification Checklist

- [ ] `flutter doctor` shows no errors
- [ ] All 6 audio files present in `assets/sounds/`
- [ ] `flutter pub get` completed successfully
- [ ] Device connected and visible in `flutter devices`
- [ ] App builds without errors
- [ ] App installs and launches on device
- [ ] Sounds play correctly (test in Settings → Sound Test)
- [ ] Game plays smoothly

## 🎊 You're Done!

The app should now be running on your device. Enjoy cursed Minesweeper! 💀

---

**Need help?** Check:
- Main `README.md` for detailed setup
- `USAGE.md` for how to play
- `assets/sounds/README.md` for audio guide
- `android/SIGNING_SETUP.md` for release signing
