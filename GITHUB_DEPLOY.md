# 🚀 GitHub Deployment Guide

## Step 1: Initialize Git Repository

If not already initialized:
```bash
cd cursed_minesweeper
git init
```

## Step 2: Create .gitignore

Make sure you have a proper .gitignore (should already exist):
```
# Flutter/Dart
.dart_tool/
.packages
build/
.flutter-plugins
.flutter-plugins-dependencies

# IDE
.idea/
*.iml
.vscode/

# Android
android/.gradle/
android/build/
android/local.properties
android/key.properties

# Other
*.log
*.swp
.DS_Store
```

## Step 3: Create GitHub Repository

1. Go to https://github.com
2. Click "New repository" (+ icon, top right)
3. Name it: `cursed-minesweeper` (or your preferred name)
4. Description: "A retro minesweeper game with audio - Built with Flutter"
5. Choose: **Public** (so you can use GitHub Pages)
6. **Don't** initialize with README (you already have one)
7. Click "Create repository"

## Step 4: Add Remote and Push

Copy the commands from GitHub (they'll look like this):

```bash
# Add remote
git remote add origin https://github.com/YOUR_USERNAME/cursed-minesweeper.git

# Add all files
git add .

# Commit
git commit -m "Initial commit: Cursed Minesweeper with web support"

# Push to GitHub
git push -u origin main
```

**Note:** If it says `master` instead of `main`, use:
```bash
git branch -M main
git push -u origin main
```

## Step 5: Deploy to GitHub Pages

### Option A: Using gh-pages Branch (Recommended)

```bash
# Build for web
flutter build web --release --base-href "/cursed-minesweeper/"

# Create gh-pages branch and push
git subtree push --prefix build/web origin gh-pages
```

### Option B: Manual Deployment

```bash
# Build for web
flutter build web --release --base-href "/cursed-minesweeper/"

# Create gh-pages branch
git checkout -b gh-pages

# Copy build files to root
cp -r build/web/* .

# Commit and push
git add .
git commit -m "Deploy to GitHub Pages"
git push origin gh-pages

# Switch back to main
git checkout main
```

## Step 6: Enable GitHub Pages

1. Go to your repository on GitHub
2. Click "Settings"
3. Scroll to "Pages" (left sidebar)
4. Under "Source", select:
   - Branch: `gh-pages`
   - Folder: `/ (root)`
5. Click "Save"

Your game will be live at:
```
https://YOUR_USERNAME.github.io/cursed-minesweeper/
```

## Step 7: Update README with Live Link

Add this to your README.md:
```markdown
## 🎮 Play Online

**[Play Now!](https://YOUR_USERNAME.github.io/cursed-minesweeper/)**
```

Commit and push:
```bash
git add README.md
git commit -m "Add live demo link"
git push
```

## Updating the Deployment

When you make changes:

```bash
# Make your changes
# ...

# Commit changes
git add .
git commit -m "Your commit message"
git push

# Rebuild and redeploy
flutter build web --release --base-href "/cursed-minesweeper/"
git subtree push --prefix build/web origin gh-pages
```

## Quick Deploy Script

Create `deploy_github.bat`:
```batch
@echo off
echo Building for GitHub Pages...
flutter build web --release --base-href "/cursed-minesweeper/"

echo Deploying to gh-pages...
git subtree push --prefix build/web origin gh-pages

echo Done! Check https://YOUR_USERNAME.github.io/cursed-minesweeper/
pause
```

## Troubleshooting

### "Updates were rejected"
```bash
# Force push (use carefully!)
git push origin `git subtree split --prefix build/web main`:gh-pages --force
```

### "fatal: 'origin' does not appear to be a git repository"
```bash
# Add remote again
git remote add origin https://github.com/YOUR_USERNAME/cursed-minesweeper.git
```

### GitHub Pages not updating
- Wait 2-3 minutes for deployment
- Check Actions tab for build status
- Clear browser cache (Ctrl+Shift+R)

### 404 Error on GitHub Pages
- Make sure base-href matches your repo name
- Check that gh-pages branch has index.html in root

## Repository Structure

Your GitHub repo will have:
```
main branch:
  - Source code
  - Documentation
  - Build scripts

gh-pages branch:
  - Built web files only
  - Automatically served by GitHub Pages
```

## Next Steps

1. ✅ Push code to GitHub
2. ✅ Deploy to GitHub Pages
3. ✅ Share your game URL!
4. 🎮 Play and enjoy!

## Additional Hosting Options

If you want alternatives to GitHub Pages:
- **Netlify**: Drag & drop `build/web` folder
- **Vercel**: Connect GitHub repo
- **Firebase**: `firebase deploy`

See `WEB_DEPLOYMENT.md` for details.

---

**Ready to deploy?** Just follow the steps above! 🚀
