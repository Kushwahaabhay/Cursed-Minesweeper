# 🎮 How to Play Cursed Minesweeper

## Game Rules

Classic Minesweeper with a cursed twist and meme audio!

### Objective
- Reveal all tiles that don't contain mines
- Use number clues to deduce mine locations
- Flag suspected mines to track them

### Controls

**Tap/Click**: Reveal tile
**Long-Press**: Place/remove flag

Or use the flag toggle button to switch between reveal and flag modes.

### Numbers Explained
- **Blank**: No adjacent mines, safe tiles auto-reveal
- **1-8**: Number of mines in adjacent 8 tiles
- **Flag**: Your marker for suspected mines
- **💣 Mine**: Game over if revealed!

## Difficulty Levels

### Beginner
- Grid: 9×9
- Mines: 10
- Perfect for learning and low-spec devices

### Intermediate
- Grid: 16×16
- Mines: 40
- Classic challenge

### Expert
- Grid: 30×16
- Mines: 99
- For minesweeper veterans only!

### Custom
- Set your own grid size and mine count
- Max recommended: 30×30 with 200 mines

## Game Features

### Timer & Scores
- Timer starts on first tile reveal
- Best times saved per difficulty
- View high scores on home screen

### Audio Events
- **Click sound**: Safe tile revealed
- **Flag sound**: Flag placed/removed
- **Explosion**: Mine hit (game over)
- **Bach gaya**: Alternative explosion sound (random)
- **Win sound**: All safe tiles revealed!
- **Lose sound**: Game over screen

### Retro Effects
- CRT vignette overlay
- Scanline shader (toggle in settings)
- Pixel font (Press Start 2P)
- Screen shake on explosion
- Tile reveal animations

## ⚙️ Settings

### Audio Settings

**Master Volume**
- Slider: 0-100%
- Affects all sounds

**Mute All**
- Quick toggle for all audio
- Useful in public spaces!

**Sound Categories**
- Toggle explosions separately
- Toggle safe sounds (click, flag, win)

**Sound Test**
- Preview each audio file
- Check volume levels
- Verify files loaded correctly

### Game Settings

**Flag Mode**
- **Tap to Flag**: Tap places flag, long-press reveals
- **Tap to Reveal** (default): Tap reveals, long-press flags

**Animations**
- Toggle tile reveal animations
- Disable for better performance on old devices

**Grid Lines**
- Show/hide grid separators
- Personal preference

## 🎯 Tips & Strategy

1. **Start with corners**: Safer first click statistically
2. **Look for patterns**: 
   - 1 touching 1 revealed tile = mine is that tile
   - 3 in a row = mines form a line
3. **Flag wisely**: Don't need to flag everything, use for tracking
4. **Count remaining mines**: Displayed at top (total - flags placed)
5. **Use both hands**: Long-press with one thumb while tapping with other

## Common Patterns

```
[1][1][ ]
[ ][ ][ ]  → Mine is top-left
```

```
[1][2][1]
[ ][?][ ]  → Mine is center bottom
```

```
[2][ ][ ]
[2][?][ ]  → Mines at both ? positions
[1][ ][ ]
```

## Known Issues

### Performance
- Expert mode may lag on devices with < 2GB RAM in debug mode
- Use release build for better performance
- Disable animations in settings if laggy

### Audio
- First sound may have slight delay (audio engine initialization)
- Overlapping sounds intentional (don't cut each other off)
- If no sound, check device isn't on silent mode

### Display
- Very small screens (< 4") may have tiny tiles on Expert
- Rotate to landscape for better Expert mode experience
- Grid auto-scales but numbers may be small on 30x16

## 🏆 Challenge Modes (Future)

Ideas for future updates:
- **Speed Run**: Beat your time
- **No Flag Mode**: Win without placing any flags
- **Guaranteed Safe Start**: First click always safe and reveals area
- **Dark Mode**: Because RGB

## Accessibility

- High contrast numbers
- Color-blind friendly (numbers also use distinct patterns)
- Large tap targets (adjustable in code)
- No time pressure (timer is just for scoring)

## FAQ

**Q: Can I undo a move?**
A: Not in current version. Think before you click!

**Q: Is the first click always safe?**
A: No, mines are placed before first click. It's pure luck!

**Q: What happens if I flag a wrong tile?**
A: No penalty! Flags are just markers, they don't affect gameplay.

**Q: Can I change audio files?**
A: Yes! Replace files in `assets/sounds/` with same filenames. See `assets/sounds/README.md`.

**Q: Why "cursed"?**
A: The meme audio makes normal Minesweeper hilariously chaotic. Use whatever sounds you find funny!

**Q: Can I remove the CRT effect?**
A: Yes, comment out the `RetroBackground` widget in `game_screen.dart`.

## Credits & Attribution

- Game design: Microsoft (original Minesweeper)
- Audio: Provide your own (see safety notice in main README)
- Font: Press Start 2P by Google Fonts

---

**Have fun and mine responsibly! 💣**
