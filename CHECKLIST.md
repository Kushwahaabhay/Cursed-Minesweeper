# ✅ FINAL SETUP CHECKLIST

Use this checklist to ensure everything is properly configured before running the app.

## 📋 Pre-Build Checklist

### ✅ System Requirements
- [ ] Flutter SDK installed (3.0.0+)
- [ ] Android SDK installed (API 21+)
- [ ] Java JDK 11 installed
- [ ] `flutter doctor` shows no critical errors
- [ ] Device connected or emulator running

### ✅ Project Setup
- [ ] Navigated to project directory: `cd d:\MINESWEPPER\cursed_minesweeper`
- [ ] Dependencies installed: `flutter pub get` completed successfully
- [ ] No errors in terminal after `flutter pub get`

### ✅ Audio Files (CRITICAL!)
- [ ] `assets/sounds/explosion.ogg` exists
- [ ] `assets/sounds/bach_gaya.ogg` exists
- [ ] `assets/sounds/flag.ogg` exists
- [ ] `assets/sounds/click.ogg` exists
- [ ] `assets/sounds/win.ogg` exists
- [ ] `assets/sounds/lose.ogg` exists
- [ ] All files are actual OGG audio files (not placeholder .txt files)
- [ ] Total audio files size < 2 MB

**⚠️ WARNING: App will crash if audio files are missing!**

### ✅ Code Verification
- [ ] All files created in correct directories
- [ ] No syntax errors visible in editor
- [ ] `pubspec.yaml` includes all dependencies
- [ ] `pubspec.yaml` includes assets declaration

## 🔨 Build Checklist

### ✅ Debug Build
- [ ] Command run: `flutter build apk --debug`
- [ ] Build completed without errors
- [ ] APK exists at: `build\app\outputs\flutter-apk\app-debug.apk`
- [ ] APK size reasonable (20-40 MB)

### ✅ Installation
- [ ] Device visible in `adb devices`
- [ ] Command run: `adb install -r build\app\outputs\flutter-apk\app-debug.apk`
- [ ] Installation successful
- [ ] App icon visible on device

### ✅ First Run
- [ ] App launches without crashing
- [ ] Home screen displays correctly
- [ ] Can select difficulty
- [ ] Start Game button works
- [ ] Game screen loads
- [ ] Grid displays correctly
- [ ] Tiles are tappable

## 🔊 Audio Testing Checklist

### ✅ Basic Audio
- [ ] Navigate to Settings
- [ ] Click Sound Test
- [ ] Test each sound:
  - [ ] Explosion plays
  - [ ] Bach Gaya plays
  - [ ] Flag plays
  - [ ] Click plays
  - [ ] Win plays
  - [ ] Lose plays
- [ ] All sounds audible (volume up!)

### ✅ Audio Controls
- [ ] Volume slider changes volume
- [ ] Mute toggle works
- [ ] Explosion sounds toggle works
- [ ] Safe sounds toggle works
- [ ] Settings persist after closing app

## 🎮 Gameplay Testing Checklist

### ✅ Basic Gameplay
- [ ] Start a game (Beginner)
- [ ] Tap a tile to reveal
- [ ] Click sound plays
- [ ] Timer starts
- [ ] Adjacent mine numbers display correctly
- [ ] Long-press to flag works
- [ ] Flag sound plays
- [ ] Flag counter updates
- [ ] Remaining mines counter updates

### ✅ Game Mechanics
- [ ] Revealing empty tile triggers flood fill
- [ ] Multiple tiles reveal at once
- [ ] Hitting mine ends game
- [ ] Explosion sound plays
- [ ] Screen shakes on explosion
- [ ] All mines revealed on loss
- [ ] Game over dialog appears
- [ ] Winning game triggers win sound
- [ ] Best time saves

### ✅ UI Features
- [ ] Reset button works
- [ ] Flag mode toggle works
- [ ] Settings button opens settings
- [ ] Back navigation works
- [ ] All text readable
- [ ] Colors display correctly (green theme)
- [ ] CRT vignette visible

## 🔐 Release Build Checklist (Optional)

### ✅ Keystore Setup
- [ ] Keystore generated: `cursed_minesweeper_keystore.jks`
- [ ] Passwords saved securely
- [ ] `android/key.properties` created
- [ ] `key.properties` has correct passwords
- [ ] `key.properties` has correct keystore path
- [ ] `android/app/build.gradle` updated with signing config

### ✅ Release Build
- [ ] Command run: `flutter build apk --release`
- [ ] Build completed without errors
- [ ] APK signed successfully
- [ ] APK exists at: `build\app\outputs\flutter-apk\app-release.apk`
- [ ] APK size < 25 MB

### ✅ Release Testing
- [ ] Release APK installed on device
- [ ] App runs smoothly (better performance than debug)
- [ ] All features work
- [ ] No debug banners visible
- [ ] App ready for distribution

## 📊 Performance Checklist

### ✅ Optimization
- [ ] Audio files optimized (OGG format, <200KB each)
- [ ] App launches in < 3 seconds
- [ ] Game plays smoothly (no lag)
- [ ] Tile animations smooth
- [ ] No frame drops during gameplay

### ✅ Low-Spec Device
- [ ] Test on low-RAM device or emulator
- [ ] Beginner mode runs smoothly
- [ ] Intermediate mode acceptable
- [ ] Expert mode playable (may lag in debug)
- [ ] Release mode recommended for old devices

## 🐛 Troubleshooting Checklist

### ❌ If App Crashes on Launch
- [ ] Check audio files exist
- [ ] Run `flutter clean`
- [ ] Run `flutter pub get`
- [ ] Rebuild and reinstall

### ❌ If No Audio
- [ ] Check device volume
- [ ] Check app not muted in settings
- [ ] Verify audio files are real OGG files, not text
- [ ] Check `pubspec.yaml` assets section

### ❌ If Build Fails
- [ ] Check Java version (needs JDK 11)
- [ ] Check Android SDK installed
- [ ] Run `flutter doctor`
- [ ] Check Gradle memory settings
- [ ] Try `flutter clean`

### ❌ If Device Not Detected
- [ ] Enable USB debugging on phone
- [ ] Check USB cable works
- [ ] Run `adb devices`
- [ ] Restart ADB: `adb kill-server && adb start-server`

## 🎯 Final Verification

### ✅ Complete Experience
- [ ] Play full game from start to win/lose
- [ ] Test all three difficulties
- [ ] Verify high scores save
- [ ] Test sound test screen
- [ ] Navigate all screens without crashes
- [ ] App feels complete and polished

### ✅ Ready for Use
- [ ] App stable
- [ ] All features working
- [ ] Audio appropriate (harmless sounds)
- [ ] Performance acceptable
- [ ] No known critical bugs

## 🎉 Success Criteria

You're done when you can:
1. ✅ Launch the app
2. ✅ Play a complete game
3. ✅ Hear all sounds
4. ✅ Win or lose gracefully
5. ✅ Navigate all screens
6. ✅ App doesn't crash

---

## 📝 Notes Section

Use this space to track issues or customizations:

```
Date: ________________
Status: ________________
Issues found:
- 
- 
- 

Customizations made:
- 
- 
- 

Performance notes:
- 
- 
- 
```

---

**Once all boxes are checked, you have a working Cursed Minesweeper app! 🎮💀**

For quick commands, see **QUICKSTART.md**
