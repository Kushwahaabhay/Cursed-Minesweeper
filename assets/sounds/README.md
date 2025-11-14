# 🔊 Audio Files Guide

## Required Files

Place the following audio files in this directory (`assets/sounds/`):

| Filename | Event | Recommended Length | Examples |
|----------|-------|-------------------|----------|
| `explosion.ogg` | Hit a mine | 0.5-2s | Boom, explosion, crash |
| `bach_gaya.ogg` | Hit a mine (alt) | 0.5-2s | Alternative explosion sound |
| `flag.ogg` | Place/remove flag | 0.2-0.5s | Click, pop, blip |
| `click.ogg` | Reveal safe tile | 0.1-0.3s | Soft click, tap, tick |
| `win.ogg` | Complete game | 1-3s | Victory fanfare, level up, applause |
| `lose.ogg` | Game over | 1-3s | Sad trombone, game over jingle, fail sound |

## 🎵 Recommended Sound Sources

### Free Sound Libraries
- **Freesound.org**: Huge library, creative commons
- **Zapsplat.com**: Free with attribution
- **Mixkit.co**: Free for commercial use
- **Pixabay Sounds**: No attribution required

### Specific Recommendations
- **Explosion**: Search "cartoon explosion", "8-bit boom", "pop sound"
- **Bach gaya**: Use "error sound", "fail sound", "buzzer"
- **Flag**: "UI click", "button press", "pop", "select"
- **Click**: "soft click", "tap", "tick", "blip"
- **Win**: "victory", "level complete", "success fanfare"
- **Lose**: "game over", "fail", "sad trombone"

## 🔧 Audio Format Requirements

### Recommended Format: OGG Vorbis
- Smaller file size than MP3
- Better quality at lower bitrates
- Native support in Flutter

### File Size Targets
- Short sounds (click, flag): 20-50 KB
- Medium sounds (explosion): 50-150 KB
- Long sounds (win, lose): 100-300 KB
- **Total for all 6 files: < 1 MB**

### Quality Settings
- **Sample Rate**: 44100 Hz or 22050 Hz (22050 for even smaller size)
- **Bitrate**: 96 kbps (balance of quality and size)
- **Channels**: Mono preferred (stereo not needed, saves 50% space)

## 🛠️ Converting Audio Files

### Install FFmpeg
**Windows**: 
- Download from https://ffmpeg.org/download.html
- Or use Chocolatey: `choco install ffmpeg`

**Linux**: 
```bash
sudo apt install ffmpeg
```

### Conversion Commands

**MP3 to OGG (good quality, small size):**
```bash
ffmpeg -i explosion.mp3 -c:a libvorbis -qscale:a 5 explosion.ogg
```

**Reduce bitrate to 96 kbps:**
```bash
ffmpeg -i sound.mp3 -c:a libvorbis -b:a 96k sound.ogg
```

**Convert to mono + 22050 Hz (smallest):**
```bash
ffmpeg -i sound.mp3 -c:a libvorbis -b:a 64k -ac 1 -ar 22050 sound.ogg
```

**Trim audio (first 2 seconds):**
```bash
ffmpeg -i sound.mp3 -t 2 -c:a libvorbis -b:a 96k sound.ogg
```

**Batch convert all MP3s in folder (PowerShell):**
```powershell
Get-ChildItem *.mp3 | ForEach-Object {
    ffmpeg -i $_.Name -c:a libvorbis -qscale:a 5 ($_.BaseName + ".ogg")
}
```

**Batch convert all MP3s in folder (Bash):**
```bash
for file in *.mp3; do
    ffmpeg -i "$file" -c:a libvorbis -qscale:a 5 "${file%.mp3}.ogg"
done
```

## 📝 If You Don't Have Audio Files Yet

### Option 1: Use Placeholder Silence
Create silent OGG files for testing:
```bash
ffmpeg -f lavfi -i anullsrc=r=22050:cl=mono -t 1 -c:a libvorbis placeholder.ogg
```

Then copy to each required filename:
```powershell
cp placeholder.ogg explosion.ogg
cp placeholder.ogg bach_gaya.ogg
cp placeholder.ogg flag.ogg
cp placeholder.ogg click.ogg
cp placeholder.ogg win.ogg
cp placeholder.ogg lose.ogg
```

### Option 2: Download Free Packs
Search for "free game sound effects pack" or "UI sound effects free" on:
- itch.io
- OpenGameArt.org
- Kenney.nl (has great free asset packs)

### Option 3: Record Your Own
Use Audacity (free) to record short sounds:
1. Record audio (keep under 2 seconds)
2. Normalize volume (Effect → Normalize)
3. Export as OGG Vorbis
4. Quality: 5 or 6

## 🎛️ Adjusting Volume Levels

If sounds are too loud/quiet:

**Normalize volume (FFmpeg):**
```bash
ffmpeg -i input.ogg -af "volume=0.5" output.ogg  # 50% volume
ffmpeg -i input.ogg -af "volume=2.0" output.ogg  # 200% volume
```

**Normalize to specific dB:**
```bash
ffmpeg -i input.ogg -filter:a "loudnorm" output.ogg
```

Or adjust in-game using the volume slider in settings!

## 📦 After Adding Files

1. Place all 6 files in `assets/sounds/`
2. Verify filenames match exactly (case-sensitive on some systems)
3. Run `flutter pub get` (may not be needed but good practice)
4. Run `flutter clean` if files don't load
5. Test sounds in-app using Settings → Sound Test

## 🔍 Troubleshooting

**Sounds not playing?**
- Check filenames are exact (no spaces, correct extension)
- Verify files are actually in `assets/sounds/` directory
- Check `pubspec.yaml` has correct assets declaration
- Try `flutter clean && flutter pub get`
- Check device volume isn't muted

**Sounds cut off each other?**
- This shouldn't happen, AudioManager uses multiple players
- Check AudioManager initialization in main.dart

**Sounds delayed on first play?**
- Normal! Audio engine initializes on first play
- Consider preloading (see AudioManager comments)

**File too large?**
- Use lower bitrate: `-b:a 64k` or `-b:a 48k`
- Convert to mono: `-ac 1`
- Lower sample rate: `-ar 22050`
- Trim to shorter duration: `-t 1.5`

## 🎨 Customizing Sound Events

To use different filenames, edit `lib/audio_manager.dart`:

```dart
// Change these constants at the top of the file
static const String _explosionSound = 'sounds/your_explosion.ogg';
static const String _flagSound = 'sounds/your_flag.ogg';
// etc...
```

## 🚀 Performance Tips

- Keep all files under 200 KB each
- Use OGG, not MP3 or WAV
- Mono is fine for these sound effects
- Lower sample rate (22050 Hz) for non-musical sounds
- Short sounds (< 2 seconds) load faster

---

**Remember: Use sounds that won't get you in trouble! Stay safe and have fun! 🎵**
