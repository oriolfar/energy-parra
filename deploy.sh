#!/bin/bash

echo "🚀 Preparing for Vercel Deployment..."

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo "❌ Error: package.json not found. Please run this script from the project root."
    exit 1
fi

# Check if all changes are committed
if [ -n "$(git status --porcelain)" ]; then
    echo "⚠️  Warning: You have uncommitted changes."
    echo "Please commit your changes before deploying:"
    echo "  git add ."
    echo "  git commit -m 'Ready for deployment'"
    echo "  git push origin main"
    exit 1
fi

echo "✅ All changes committed"

# Install dependencies
echo "📦 Installing dependencies..."
pnpm install

# Run type checking
echo "🔍 Running type checks..."
cd apps/web && npx tsc --noEmit && cd ../..

# Run linting
echo "🧹 Running linting..."
pnpm lint

# Build the project
echo "🏗️  Building project..."
pnpm build

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    echo ""
    echo "🚀 Ready to deploy to Vercel!"
    echo ""
    echo "Next steps:"
    echo "1. Go to https://vercel.com"
    echo "2. Click 'New Project'"
    echo "3. Import your GitHub repository"
    echo "4. Configure build settings:"
    echo "   - Framework Preset: Next.js"
    echo "   - Build Command: pnpm build"
    echo "   - Output Directory: .next"
    echo "   - Install Command: pnpm install --no-frozen-lockfile"
    echo "5. Deploy!"
    echo ""
    echo "Or use Vercel CLI:"
    echo "  npm i -g vercel"
    echo "  vercel login"
    echo "  vercel --prod"
else
    echo "❌ Build failed. Please fix the errors above before deploying."
    exit 1
fi 