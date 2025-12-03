# Web Deployment Guide

## Running Locally

### Development Mode
Run the game in debug mode with hot reload:
```bash
cd cursed_minesweeper
flutter run -d chrome
```

Or use Edge browser:
```bash
flutter run -d edge
```

### Production Build
Build an optimized production version:
```bash
flutter build web --release
```

The output will be in `build/web/` directory.

## Testing the Build

After building, you can test the production build locally:

### Using Python (if installed)
```bash
cd build/web
python -m http.server 8000
```
Then open: http://localhost:8000

### Using Node.js (if installed)
```bash
cd build/web
npx serve
```

### Using Flutter's built-in server
```bash
flutter run -d web-server --web-port=8080
```
Then open: http://localhost:8080

## Deployment Options

### 1. GitHub Pages (Free)

**Step 1:** Build with base href
```bash
flutter build web --release --base-href "/cursed_minesweeper/"
```

**Step 2:** Push to GitHub
```bash
git add build/web
git commit -m "Deploy to GitHub Pages"
git subtree push --prefix build/web origin gh-pages
```

**Step 3:** Enable GitHub Pages in repository settings
- Go to Settings > Pages
- Select `gh-pages` branch
- Your game will be at: `https://yourusername.github.io/cursed_minesweeper/`

### 2. Netlify (Free)

**Option A: Drag & Drop**
1. Build: `flutter build web --release`
2. Go to https://app.netlify.com/drop
3. Drag the `build/web` folder
4. Done! You'll get a URL like: `https://random-name.netlify.app`

**Option B: CLI**
```bash
npm install -g netlify-cli
flutter build web --release
cd build/web
netlify deploy --prod
```

### 3. Vercel (Free)

```bash
npm install -g vercel
flutter build web --release
cd build/web
vercel --prod
```

### 4. Firebase Hosting (Free)

```bash
npm install -g firebase-tools
firebase login
firebase init hosting
# Select build/web as public directory
flutter build web --release
firebase deploy
```

### 5. Cloudflare Pages (Free)

1. Push your code to GitHub
2. Go to https://pages.cloudflare.com
3. Connect your repository
4. Build command: `flutter build web --release`
5. Build output directory: `build/web`

## Web-Specific Optimizations

### 1. Enable CanvasKit (Better Performance)
```bash
flutter build web --release --web-renderer canvaskit
```

### 2. Enable HTML Renderer (Smaller Size)
```bash
flutter build web --release --web-renderer html
```

### 3. Auto Renderer (Recommended)
```bash
flutter build web --release --web-renderer auto
```
This automatically chooses the best renderer for each browser.

## Performance Tips

### Audio on Web
- Audio files are loaded on demand
- First audio play might have a slight delay (browser limitation)
- Use `.ogg` format for better compression
- Consider preloading audio in production

### Large Grids
- 64×64 grids work well on modern browsers
- Mobile browsers might struggle with extreme modes
- Consider adding a warning for mobile users

### PWA Features
The game is configured as a Progressive Web App:
- ✅ Can be installed on desktop/mobile
- ✅ Works offline (after first load)
- ✅ App-like experience
- ✅ Custom theme colors

## Browser Compatibility

### Fully Supported
- ✅ Chrome/Edge (latest)
- ✅ Firefox (latest)
- ✅ Safari (latest)
- ✅ Opera (latest)

### Mobile Browsers
- ✅ Chrome Mobile
- ✅ Safari iOS
- ✅ Samsung Internet
- ⚠️ May have audio autoplay restrictions

## Troubleshooting

### Audio Not Playing
**Issue:** Audio doesn't play on first click

**Solution:** Browsers require user interaction before playing audio. The game handles this automatically, but first click might be silent.

### Large Grid Performance
**Issue:** 64×64 grid is slow

**Solution:** 
- Use CanvasKit renderer: `flutter build web --web-renderer canvaskit`
- Close other browser tabs
- Use a modern browser

### Build Errors
**Issue:** Build fails with errors

**Solution:**
```bash
flutter clean
flutter pub get
flutter build web --release
```

### CORS Errors (Local Testing)
**Issue:** Assets not loading locally

**Solution:** Use a local server (see "Testing the Build" section above)

## Custom Domain

After deploying to any platform, you can add a custom domain:

1. **Netlify/Vercel/Cloudflare:** 
   - Go to domain settings
   - Add your custom domain
   - Update DNS records

2. **GitHub Pages:**
   - Add `CNAME` file to `build/web/` with your domain
   - Update DNS to point to GitHub Pages

## Build Optimization

### Reduce Build Size
```bash
flutter build web --release --tree-shake-icons --split-debug-info=debug_info
```

### Enable Compression
Most hosting platforms automatically compress files. If self-hosting:
- Enable gzip compression on your server
- Use Brotli compression for even better results

## Environment Variables

For different environments, create build scripts:

**build_dev.bat:**
```batch
flutter build web --release --dart-define=ENV=dev
```

**build_prod.bat:**
```batch
flutter build web --release --dart-define=ENV=prod
```

## Monitoring

### Analytics (Optional)
Add Google Analytics or similar to track:
- Player count
- Popular difficulty levels
- Average game time
- Win rates

### Error Tracking
Consider adding Sentry or similar for error tracking in production.

## Quick Deploy Script

Create `deploy.bat` for easy deployment:
```batch
@echo off
echo Building for web...
flutter build web --release --web-renderer auto

echo Build complete! Files are in build/web/
echo.
echo Deploy options:
echo 1. Netlify: cd build/web && netlify deploy --prod
echo 2. Vercel: cd build/web && vercel --prod
echo 3. Firebase: firebase deploy
echo 4. GitHub Pages: git subtree push --prefix build/web origin gh-pages
```

## Security Considerations

- ✅ No sensitive data stored
- ✅ All data stored locally (SharedPreferences)
- ✅ No external API calls
- ✅ No user authentication required
- ✅ Safe for public deployment

## Next Steps

1. Build the web version: `flutter build web --release`
2. Test locally: `cd build/web && python -m http.server`
3. Choose a hosting platform (Netlify recommended for beginners)
4. Deploy and share your game!

## Support

For issues specific to web deployment:
- Flutter Web Docs: https://docs.flutter.dev/platform-integration/web
- Flutter Discord: https://discord.gg/flutter
- Stack Overflow: Tag with `flutter-web`

---

**Ready to deploy?** Start with Netlify's drag-and-drop for the easiest deployment!
