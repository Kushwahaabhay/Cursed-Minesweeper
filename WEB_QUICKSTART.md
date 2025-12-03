# 🚀 Web Quick Start Guide

## Run Locally (Development)

### Option 1: Using the Script (Easiest)
Double-click `run_web.bat` - it will automatically open in Chrome!

### Option 2: Manual Command
```bash
flutter run -d chrome
```

## Build for Production

### Option 1: Using the Script (Easiest)
Double-click `build_web.bat` - it will build and show deployment options!

### Option 2: Manual Command
```bash
flutter build web --release
```

Output will be in `build/web/` folder.

## Test Production Build Locally

After building, test it locally:

```bash
cd build/web
python -m http.server 8000
```

Then open: http://localhost:8000

## Deploy (Choose One)

### 🎯 Netlify (Recommended - Easiest!)

1. Build: `flutter build web --release`
2. Go to: https://app.netlify.com/drop
3. Drag the `build/web` folder
4. Done! You get a free URL instantly

**Pros:** 
- ✅ Instant deployment
- ✅ Free SSL certificate
- ✅ Custom domain support
- ✅ Automatic CDN

### 🐙 GitHub Pages (Free)

```bash
flutter build web --release --base-href "/cursed_minesweeper/"
git add build/web
git subtree push --prefix build/web origin gh-pages
```

Enable in Settings > Pages > Select `gh-pages` branch

**Your URL:** `https://yourusername.github.io/cursed_minesweeper/`

### ⚡ Vercel (Fast)

```bash
npm install -g vercel
flutter build web --release
cd build/web
vercel --prod
```

### 🔥 Firebase (Google)

```bash
npm install -g firebase-tools
firebase login
firebase init hosting
flutter build web --release
firebase deploy
```

## Browser Support

✅ **Desktop:**
- Chrome/Edge (Recommended)
- Firefox
- Safari
- Opera

✅ **Mobile:**
- Chrome Mobile
- Safari iOS
- Samsung Internet

## Features on Web

✅ Works offline (after first load)
✅ Can be installed as PWA
✅ Full audio support
✅ All difficulty levels (9×9 to 64×64)
✅ Touch controls on mobile
✅ Responsive design

## Performance Tips

### For Best Performance:
1. Use Chrome or Edge browser
2. Close unnecessary tabs
3. For 64×64 grids, use desktop browser

### Build Optimizations:
```bash
# Smaller size (HTML renderer)
flutter build web --release --web-renderer html

# Better performance (CanvasKit)
flutter build web --release --web-renderer canvaskit

# Auto-select (Recommended)
flutter build web --release --web-renderer auto
```

## Common Issues

### Audio doesn't play?
- Browsers require user interaction first
- Click anywhere to enable audio
- Check browser audio permissions

### Game is slow?
- Try CanvasKit renderer
- Use a modern browser
- Close other tabs

### Build fails?
```bash
flutter clean
flutter pub get
flutter build web --release
```

## File Size

Production build size:
- ~2-3 MB (compressed)
- ~8-10 MB (uncompressed)
- First load: ~3-5 seconds
- Subsequent loads: Instant (cached)

## What's Included

✅ All game features
✅ Audio support
✅ High score tracking (local storage)
✅ All 7 difficulty levels
✅ Responsive design
✅ PWA support
✅ Offline capability

## Next Steps

1. **Test locally:** Run `run_web.bat`
2. **Build:** Run `build_web.bat`
3. **Deploy:** Choose Netlify for easiest deployment
4. **Share:** Send the URL to friends!

## Need Help?

See `WEB_DEPLOYMENT.md` for detailed deployment guide.

---

**Ready?** Just double-click `run_web.bat` to start! 🎮
