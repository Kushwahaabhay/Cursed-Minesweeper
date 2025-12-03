# 🎮 Cursed Minesweeper

A retro Minesweeper clone with custom audio effects. Built with Flutter.

**Now available on Web!** 🌐 Play in your browser with full audio support.

## 🎯 Platforms

- ✅ **Windows** - Native desktop app
- ✅ **Android** - Mobile app (APK)
- ✅ **Web** - Play in browser (NEW!)
- 🔜 **Linux** - Coming soon
- 🔜 **iOS** - Coming soon

## 📋 Prerequisites

- **Flutter SDK**: 3.0.0 or higher (with null-safety)
- **Android Studio** or VS Code with Flutter extension (for mobile)
- **Java JDK 11** (for Android builds)
- **Android SDK** with API level 21+ (Android 5.0+)
- **Chrome/Edge** (for web development)
- **FFmpeg** (optional, for audio conversion)

### Check Your Setup
```bash
flutter doctor -v
java -version
```

## 🚀 Quick Start

### Web (Easiest!)
```bash
# Run in browser
run_web.bat

# Or manually
flutter run -d chrome
```
See `WEB_QUICKSTART.md` for deployment options.

### Windows/Android

1. **Navigate to project directory:**
```powershell
cd d:\MINESWEPPER\cursed_minesweeper
```

2. **Install dependencies:**
```powershell
flutter pub get
```

3. **Add your audio files** (see `assets/sounds/README.md` for details)

4. **Run on connected device:**
```powershell
flutter devices  # List available devices
flutter run -d <device-id>  # Replace with actual device ID
```

Or for better performance on low-spec machines:
```powershell
flutter run --release
```

## 📁 Project Structure

```
cursed_minesweeper/
├── lib/
│   ├── main.dart                 # Entry point
│   ├── audio_manager.dart        # Audio playback singleton
│   ├── game/
│   │   ├── game_state.dart       # Core Minesweeper logic
│   │   ├── tile.dart             # Tile model
│   │   └── difficulty.dart       # Difficulty presets
│   ├── screens/
│   │   ├── home_screen.dart      # Main menu
│   │   ├── game_screen.dart      # Game board
│   │   ├── settings_screen.dart  # Audio/game settings
│   │   └── sound_test_screen.dart # Test audio playback
│   └── widgets/
│       ├── tile_widget.dart      # Individual tile UI
│       ├── game_controls.dart    # Timer, mine counter, etc.
│       └── retro_background.dart # CRT effect background
├── assets/
│   ├── sounds/                   # Audio files (MP3/OGG)
│   │   └── README.md             # Audio file requirements
│   └── fonts/
│       └── PressStart2P-Regular.ttf  # Pixel font
├── test/
│   └── game_logic_test.dart      # Unit tests
├── android/                      # Android-specific config
└── pubspec.yaml                  # Dependencies & assets
```

## 🎵 Audio Setup

### Required Audio Files

Place these files in `assets/sounds/`:
- `explosion.ogg` - When you hit a mine
- `bach_gaya.ogg` - Alternative explosion sound
- `flag.ogg` - Placing/removing flag
- `click.ogg` - Revealing safe tile
- `win.ogg` - Game won
- `lose.ogg` - Game over

**See `assets/sounds/README.md` for detailed instructions.**

### Converting Audio with FFmpeg

Convert MP3 to OGG (reduces file size):
```bash
ffmpeg -i sound.mp3 -c:a libvorbis -qscale:a 5 sound.ogg
```

Reduce bitrate for smaller APK:
```bash
ffmpeg -i sound.mp3 -b:a 96k sound.ogg
```

Batch convert all MP3s in folder (PowerShell):
```powershell
Get-ChildItem *.mp3 | ForEach-Object { ffmpeg -i $_.Name -c:a libvorbis -qscale:a 5 ($_.BaseName + ".ogg") }
```

## 🔨 Building APK

### Debug APK (Quick Testing)
```powershell
flutter build apk --debug
```

Output: `build\app\outputs\flutter-apk\app-debug.apk`

### Release APK (Optimized)

**Step 1: Create Keystore** (one-time setup)
```bash
keytool -genkey -v -keystore %USERPROFILE%\cursed_minesweeper_keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias cursedkey
```

Follow prompts and **remember your passwords!**

**Step 2: Create `android/key.properties`**
```properties
storePassword=YOUR_KEYSTORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=cursedkey
storeFile=C:/Users/YourUsername/cursed_minesweeper_keystore.jks
```

**Step 3: Edit `android/app/build.gradle`**

Add this **before** `android {` block:
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
```

Inside `android { ... }` block, add:
```gradle
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
        storePassword keystoreProperties['storePassword']
    }
}
buildTypes {
    release {
        signingConfig signingConfigs.release
        minifyEnabled true
        shrinkResources true
    }
}
```

**Step 4: Build Release APK**
```powershell
flutter build apk --release
```

Output: `build\app\outputs\flutter-apk\app-release.apk`

### Split APKs by ABI (Smaller Size)
```powershell
flutter build apk --split-per-abi
```

Generates separate APKs for arm64-v8a, armeabi-v7a, x86_64 (~30% smaller each).

### Play Store Bundle
```powershell
flutter build appbundle --release
```

Output: `build\app\outputs\bundle\release\app-release.aab`

## 📱 Installing APK

### Via USB (ADB)
```powershell
adb install -r build\app\outputs\flutter-apk\app-release.apk
```

### Manual Install
Transfer APK to phone and open it. Enable "Install from Unknown Sources" in Android settings.

## 🎮 How to Play

See `USAGE.md` for gameplay instructions and settings explanation.

## 🐛 Troubleshooting

### Build Runs Out of Memory
Edit `android/gradle.properties`:
```properties
org.gradle.jvmargs=-Xmx2048m -XX:MaxPermSize=512m -XX:+HeapDumpOnOutOfMemoryError
```

### Slow Performance on Low-Spec Laptop
- Use `flutter run --release` instead of debug mode
- Close other apps to free RAM
- Reduce grid size (use Beginner mode)

### Audio Not Playing
- Check files are in `assets/sounds/` with exact filenames
- Verify `pubspec.yaml` includes assets
- Run `flutter clean && flutter pub get`
- Check device volume isn't muted

### Gradle Build Fails
```powershell
cd android
.\gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk
```

### Java Version Issues
Ensure JDK 11 is installed and set in environment variables:
```powershell
$env:JAVA_HOME = "C:\Program Files\Java\jdk-11.0.xx"
```

### APK Too Large
- Convert audio to OGG with lower bitrate
- Use `--split-per-abi` flag
- Enable shrinkResources in build.gradle

## 🎨 Customization

### Change Default Difficulty
Edit `lib/screens/home_screen.dart`, line ~30:
```dart
Difficulty _selectedDifficulty = Difficulty.intermediate; // Change here
```

### Swap Audio Files
Replace files in `assets/sounds/` keeping the same names, or edit `lib/audio_manager.dart` to update filenames.

### Modify Colors/Theme
Edit `lib/main.dart` theme settings and `lib/widgets/tile_widget.dart` number colors.

### Adjust Grid Tile Size
Edit `lib/screens/game_screen.dart`, `_calculateTileSize()` function.

## 📊 Performance Tips

- Audio files should be < 100KB each (use OGG, 96kbps)
- Total app size target: < 15MB
- Beginner mode (9x9) works well on all devices
- Expert mode (30x16) may lag on old phones in debug mode

## 🧪 Testing

Run unit tests:
```powershell
flutter test
```

Run specific test file:
```powershell
flutter test test/game_logic_test.dart
```

## 📄 License

This is a personal/educational project. Ensure you have rights to any audio files you include.

## 🙏 Credits

- Pixel font: Google Fonts - Press Start 2P
- Audio package: `audioplayers` by Blue Fire
- Inspiration: Classic Microsoft Minesweeper + internet brainrot culture

---

## 📦 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## � License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👤 Author

**Abhay Kushwaha**
- GitHub: [@Kushwahaabhay](https://github.com/Kushwahaabhay)
- Repository: [Cursed-Minesweeper](https://github.com/Kushwahaabhay/Cursed-Minesweeper)

## ⭐ Show Your Support

Give a ⭐️ if you like this project!

---

**Made with 💀 by Abhay**
