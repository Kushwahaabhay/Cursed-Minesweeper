# 📋 PROJECT STRUCTURE & FILES

Complete overview of the Cursed Minesweeper project.

## 📁 Directory Structure

```
cursed_minesweeper/
├── android/                          # Android-specific configuration
│   ├── app/
│   │   └── build.gradle              # Build config (edit for signing)
│   ├── key.properties.template       # Template for signing keys
│   └── SIGNING_SETUP.md              # Signing instructions
├── assets/
│   └── sounds/                       # Audio files directory
│       ├── explosion.ogg             # Mine hit sound
│       ├── bach_gaya.ogg             # Alternative explosion
│       ├── flag.ogg                  # Flag placed/removed
│       ├── click.ogg                 # Safe tile revealed
│       ├── win.ogg                   # Game won
│       ├── lose.ogg                  # Game over
│       ├── README.md                 # Audio setup guide
│       └── *.ogg.txt                 # Placeholder files
├── lib/
│   ├── main.dart                     # App entry point
│   ├── audio_manager.dart            # Audio playback singleton
│   ├── game/                         # Game logic
│   │   ├── difficulty.dart           # Difficulty presets
│   │   ├── tile.dart                 # Tile model
│   │   └── game_state.dart           # Core Minesweeper logic
│   ├── screens/                      # UI screens
│   │   ├── home_screen.dart          # Main menu
│   │   ├── game_screen.dart          # Game board
│   │   ├── settings_screen.dart      # Audio/game settings
│   │   └── sound_test_screen.dart    # Test audio playback
│   └── widgets/                      # Reusable widgets
│       ├── tile_widget.dart          # Individual tile UI
│       ├── game_controls.dart        # Timer, mine counter
│       └── retro_background.dart     # CRT effect
├── test/
│   └── game_logic_test.dart          # Unit tests
├── pubspec.yaml                      # Dependencies & assets
├── README.md                         # Main documentation
├── USAGE.md                          # How to play
├── QUICKSTART.md                     # Quick setup guide (THIS IS IMPORTANT!)
└── .gitignore                        # Git ignore rules
```

## 📦 Dependencies (pubspec.yaml)

### Runtime Dependencies
- `audioplayers: ^5.2.1` - Audio playback
- `provider: ^6.1.1` - State management
- `shared_preferences: ^2.2.2` - Local storage for scores
- `google_fonts: ^6.1.0` - Pixel font (Press Start 2P)

### Dev Dependencies
- `flutter_test` - Testing framework
- `flutter_lints` - Code quality

## 🎯 Key Files Explained

### Core Game Logic

**`lib/game/game_state.dart`** (287 lines)
- Main game controller
- Mine placement algorithm
- Flood-fill reveal logic
- Win/lose detection
- Timer management
- Functions: `revealTile()`, `toggleFlag()`, `_floodFillReveal()`

**`lib/game/tile.dart`** (38 lines)
- Tile model class
- Properties: `isMine`, `isRevealed`, `isFlagged`, `adjacentMines`

**`lib/game/difficulty.dart`** (76 lines)
- Preset difficulties (Beginner, Intermediate, Expert)
- Custom difficulty factory

### Audio System

**`lib/audio_manager.dart`** (185 lines)
- Singleton audio controller
- Multiple audio players for overlapping sounds
- Volume control, mute toggle
- Category toggles (explosions vs safe sounds)
- Functions: `playExplosion()`, `playClick()`, `playFlag()`, etc.
- Settings persistence via SharedPreferences

### UI Screens

**`lib/screens/home_screen.dart`** (261 lines)
- Difficulty selection
- Best times display
- Start game button
- Navigation to settings

**`lib/screens/game_screen.dart`** (331 lines)
- Minesweeper grid display
- Tile interaction handling
- Timer updates
- Screen shake effect on explosion
- Flag mode toggle
- Game over dialogs

**`lib/screens/settings_screen.dart`** (176 lines)
- Volume slider
- Mute toggle
- Explosion/safe sounds toggles
- Sound test navigation
- About section with safety warning

**`lib/screens/sound_test_screen.dart`** (141 lines)
- Buttons to test each sound
- Labeled with descriptions
- Helps verify audio files loaded

### UI Widgets

**`lib/widgets/tile_widget.dart`** (161 lines)
- Individual tile rendering
- Classic Minesweeper number colors
- Reveal animation (scale effect)
- Flagged/revealed states
- Mine icon display

**`lib/widgets/game_controls.dart`** (76 lines)
- Timer display
- Remaining mines counter
- Reset button
- Settings button

**`lib/widgets/retro_background.dart`** (71 lines)
- CRT vignette effect
- Optional scanline shader
- Performance-friendly

### Testing

**`test/game_logic_test.dart`** (194 lines)
- Unit tests for game logic
- Tests mine placement, adjacent counts
- Tests reveal, flag, win conditions
- Tests difficulty constraints

## 🎨 Theme & Colors

### Color Palette
- Background: `#0a0a0a` (near black)
- Primary (text, borders): `#00FF00` (retro green)
- Secondary: `#FF00FF` (magenta)
- Surface: `#1a1a1a` (dark gray)
- Tile unrevealed: `#2a2a2a`
- Tile revealed: `#1a1a1a`

### Number Colors (Classic Minesweeper)
- 1: Blue (`#0000FF`)
- 2: Green (`#008000`)
- 3: Red (`#FF0000`)
- 4: Dark Blue (`#000080`)
- 5: Maroon (`#800000`)
- 6: Cyan (`#008080`)
- 7: Black (`#000000`)
- 8: Gray (`#808080`)

### Font
- **Press Start 2P** via Google Fonts
- Fallback to system font if offline

## 🔊 Audio File Requirements

| File | Event | Length | Size Target |
|------|-------|--------|-------------|
| explosion.ogg | Mine hit | 0.5-2s | <150KB |
| bach_gaya.ogg | Mine hit (alt) | 0.5-2s | <150KB |
| flag.ogg | Flag toggle | 0.2-0.5s | <50KB |
| click.ogg | Reveal tile | 0.1-0.3s | <50KB |
| win.ogg | Victory | 1-3s | <200KB |
| lose.ogg | Game over | 1-3s | <200KB |

**Total target: <1MB for all sounds**

## ⚙️ Configuration Points

### Change Default Difficulty
`lib/screens/home_screen.dart`, line ~16:
```dart
Difficulty _selectedDifficulty = Difficulty.beginner; // Change here
```

### Modify Audio Filenames
`lib/audio_manager.dart`, lines 17-22:
```dart
static const String _explosionSound = 'sounds/explosion.ogg';
// etc...
```

### Adjust Tile Size Range
`lib/screens/game_screen.dart`, line ~197:
```dart
return tileSize.clamp(20.0, 40.0); // Adjust min/max
```

### Change Max Players (Audio Overlap)
`lib/audio_manager.dart`, line 29:
```dart
final int _maxPlayers = 5; // Increase for more overlapping sounds
```

### Modify Theme Colors
`lib/main.dart`, lines 29-49:
```dart
primaryColor: const Color(0xFF00FF00), // Change theme
```

### Enable/Disable Scanlines
`lib/screens/game_screen.dart`, line 218:
```dart
child: RetroBackground(
  enableScanlines: true, // Set to true/false
```

## 🚀 Build Outputs

### Debug APK
- Path: `build\app\outputs\flutter-apk\app-debug.apk`
- Size: ~30-40 MB
- Not optimized

### Release APK (Universal)
- Path: `build\app\outputs\flutter-apk\app-release.apk`
- Size: ~15-25 MB (depends on audio)
- Optimized, minified

### Release APK (Split)
- Paths: `build\app\outputs\flutter-apk\app-*-release.apk`
- arm64-v8a: ~10-15 MB
- armeabi-v7a: ~10-15 MB
- x86_64: ~15-20 MB

### App Bundle (Play Store)
- Path: `build\app\outputs\bundle\release\app-release.aab`
- Size: ~15-20 MB
- Google Play optimization

## 🧪 Testing

### Run All Tests
```powershell
flutter test
```

### Test Coverage
Current tests cover:
- ✅ Grid initialization
- ✅ Mine placement
- ✅ Adjacent mine calculation
- ✅ Tile reveal logic
- ✅ Flag toggle
- ✅ Win/lose conditions
- ✅ Difficulty validation

### Manual Testing Checklist
- [ ] Audio plays on all events
- [ ] Volume slider works
- [ ] Mute toggle works
- [ ] Tiles reveal correctly
- [ ] Flags place/remove correctly
- [ ] Flood fill reveals empty areas
- [ ] Timer starts on first click
- [ ] Win detection works
- [ ] Lose detection works
- [ ] High scores save
- [ ] Settings persist
- [ ] Game resets properly
- [ ] Screen shake on explosion
- [ ] Animations smooth

## 📝 Code Statistics

- **Total Dart Files**: 14
- **Total Lines of Code**: ~2,500
- **Average File Size**: ~180 lines
- **Test Coverage**: ~200 lines

## 🔒 Security Notes

### Sensitive Files (DO NOT COMMIT)
- `android/key.properties` - Contains passwords
- `*.jks`, `*.keystore` - Signing keys
- Audio files (if copyrighted/personal)

### .gitignore Configured For
- Build artifacts
- IDE files
- Signing keys
- Audio files (except README and placeholders)

## 🎮 Gameplay Features

### Implemented
- ✅ Three difficulty levels
- ✅ Custom difficulty option
- ✅ Timer
- ✅ Mine counter
- ✅ Flag mode toggle
- ✅ Long-press to flag
- ✅ Flood fill reveal
- ✅ Win/lose detection
- ✅ High score tracking
- ✅ Audio on all events
- ✅ Volume control
- ✅ Mute toggle
- ✅ Sound categories
- ✅ Settings persistence
- ✅ Retro theme
- ✅ CRT effects
- ✅ Screen shake
- ✅ Tile animations

### Future Enhancements (Ideas)
- [ ] Undo last move
- [ ] Hint system
- [ ] Guaranteed safe first click
- [ ] Dark mode toggle
- [ ] More themes
- [ ] Achievements
- [ ] Statistics tracking
- [ ] Online leaderboards
- [ ] Multiplayer mode

## 📱 Compatibility

### Minimum Requirements
- Android 5.0 (API 21+)
- 100 MB free space
- 512 MB RAM

### Recommended
- Android 7.0+ (API 24+)
- 1 GB RAM
- Screen size 4"+ for Expert mode

### Tested On
- Low-spec laptop (development)
- Android emulator
- Should work on most devices

## 🛠️ Development Tools

### Required
- Flutter SDK 3.0.0+
- Android SDK (API 21+)
- Java JDK 11

### Optional
- Android Studio
- VS Code with Flutter extension
- FFmpeg (audio conversion)

## 📚 Documentation Files

1. **README.md** - Main guide, setup, building, troubleshooting
2. **USAGE.md** - How to play, controls, tips, FAQ
3. **QUICKSTART.md** - Fast setup, copy-paste commands (USE THIS!)
4. **assets/sounds/README.md** - Audio guide, safe sources, conversion
5. **android/SIGNING_SETUP.md** - Release signing instructions
6. **PROJECT_OVERVIEW.md** - This file!

## 🎯 Quick Reference

### Most Important Commands
```powershell
flutter pub get              # Install dependencies
flutter run --release        # Run on device (best performance)
flutter build apk --release  # Build release APK
flutter test                 # Run tests
flutter clean                # Clean build
```

### Most Important Files to Edit
1. `assets/sounds/` - Add your audio files here
2. `lib/screens/home_screen.dart` - Change default difficulty
3. `lib/audio_manager.dart` - Customize audio behavior
4. `android/key.properties` - Add signing keys
5. `lib/main.dart` - Modify theme/colors

### Most Common Issues
1. **No audio** → Check files exist in `assets/sounds/`
2. **Build fails** → Run `flutter clean && flutter pub get`
3. **Slow performance** → Use `flutter run --release`
4. **Out of memory** → Edit `android/gradle.properties`

---

**Everything you need to know about the project structure is here!**

For quick setup, go to **QUICKSTART.md** →
