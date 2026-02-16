# Deployment Guide

Your personal website is ready! Here's how to deploy it to GitHub Pages.

## Quick Start

Your site is located at: `~/personal-website`

Git repository has been initialized and all files are staged.

## Step 1: Create GitHub Repository

1. Go to [GitHub](https://github.com/new)
2. Create a repository named `[your-username].github.io`
   - Replace `[your-username]` with your actual GitHub username
   - For example: `johndoe.github.io`
3. Make it **public**
4. **Do NOT** initialize with README (we already have one)

## Step 2: Update Configuration

Before pushing, update these files:

### hugo.toml
```toml
baseURL = 'https://[your-username].github.io/'
title = '[Your Name] - Research & Writing'

[params]
  author = "[Your Name]"
```

Replace:
- `[your-username]` with your GitHub username
- `[Your Name]` with your actual name

### newsletter.html (Optional - for Buttondown)

If you want to set up the newsletter:

1. Sign up at https://buttondown.email
2. Get your username
3. Edit `layouts/partials/newsletter.html`
4. Replace `[your-username]` in the form action URL

## Step 3: Customize Content

Edit these files with your information:

- `content/_index.md` - Homepage
- `content/bio/index.md` - Your bio
- `content/research/index.md` - Research interests

## Step 4: Commit and Push

```bash
cd ~/personal-website

# Make any edits from Step 2 and 3, then:
git add .
git commit -m "Initial commit: Personal website"

# Add your GitHub repository as remote
git remote add origin https://github.com/[your-username]/[your-username].github.io.git

# Push to GitHub
git push -u origin main
```

## Step 5: Enable GitHub Pages

1. Go to your repository on GitHub
2. Click **Settings** → **Pages**
3. Under "Build and deployment":
   - **Source**: Select "GitHub Actions"
4. Wait a few minutes for the action to complete

Your site will be live at: `https://[your-username].github.io`

## Verify Deployment

1. Go to **Actions** tab in your GitHub repository
2. You should see a workflow run called "Deploy to GitHub Pages"
3. Wait for it to complete (green checkmark)
4. Visit your site URL

## Adding New Blog Posts

```bash
# Create a new post
cd ~/personal-website
hugo new blog/posts/my-new-post.md

# Edit the file
# Set draft: false when ready

# Commit and push
git add content/blog/posts/my-new-post.md
git commit -m "Add new post: My New Post"
git push

# Site will automatically rebuild and deploy!
```

## Local Development

Test changes locally before pushing:

```bash
cd ~/personal-website
hugo server -D

# Visit http://localhost:1313
# Press Ctrl+C to stop
```

## Features Demonstration

The welcome post (`content/blog/posts/welcome.md`) demonstrates:
- ✅ Footnotes with hover preview
- ✅ Citations with hover
- ✅ Bibliography
- ✅ Code blocks
- ✅ Formatting

View it locally to test these features!

## Troubleshooting

### GitHub Actions failing?

- Check that you enabled "GitHub Actions" as the source (not "Deploy from a branch")
- Verify the workflow file exists: `.github/workflows/deploy.yml`

### Site not updating?

- Check the Actions tab for errors
- Make sure you pushed to `main` branch
- Clear your browser cache

### Newsletter not working?

- Sign up for Buttondown first
- Update the form action URL in `layouts/partials/newsletter.html`

## Next Steps

1. Add your custom domain (optional)
2. Set up Buttondown newsletter
3. Add more content
4. Customize the design in `static/css/style.css`
5. Add analytics (Plausible, GoatCounter, etc.)

## Support

- Hugo docs: https://gohugo.io/documentation/
- GitHub Pages: https://docs.github.com/pages
- Buttondown: https://buttondown.email/help

Your website is ready to go! 🚀
