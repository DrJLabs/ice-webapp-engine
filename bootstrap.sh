#!/bin/bash
set -e

### 1. Fork & clone boilerplate (Next.js 15 stack)
echo "🚀 Forking Next.js boilerplate..."
gh repo fork ixartz/Next-js-Boilerplate --clone --remote upstream
mv upstream ice-webapp-engine && cd ice-webapp-engine
git remote remove upstream
gh repo create "DrJsPBs/ice-webapp-engine" --public --source=. --remote=origin --push

### 2. Transplant ESLint/Prettier/tsconfig from old repo
echo "📦 Transplanting configs from existing ice-webapp..."
OLD=../../ice-webapp    # Path to existing ice-webapp
for f in .eslintrc.json .prettierrc.json tsconfig.json tests/setup.ts; do
  if [ -f "$OLD/$f" ]; then 
    echo "  Copying $f"
    cp "$OLD/$f" "$f"
  else
    echo "  Skipping $f (not found)"
  fi
done

### 3. Enable monorepo folders & workspaces
echo "🏗️  Setting up monorepo structure..."
mkdir -p apps/web packages/shared

# Move Next.js files to apps/web
if [ -d "src" ]; then
  git mv src apps/web/
fi
if [ -d "public" ]; then
  git mv public apps/web/
fi
if [ -d "pages" ]; then
  git mv pages apps/web/
fi

# Move config files
for config in next.config.* vitest.config.* playwright.config.*; do
  if [ -f "$config" ]; then
    git mv "$config" apps/web/ 2>/dev/null || true
  fi
done

# Setup workspace package.json
echo "📄 Updating package.json for workspaces..."
npm pkg set private=true
npm pkg set workspaces='["apps/*","packages/*"]'

# Setup web app package.json
cd apps/web
npm pkg set name="web"
cd ../..

# Setup shared package
cd packages/shared
npm init -y
npm pkg set name="@ice/shared"
cd ../..

echo "📥 Installing dependencies..."
npm install

echo "💾 Committing initial setup..."
git add .
git commit -m "feat(init): scaffold Next.js boilerplate, add workspaces & configs"
git push -u origin main

echo "✅ Pass #1 completed successfully!" 