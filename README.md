# Personal Website

A minimal, brutalist-style personal website built with Hugo and deployed to GitHub Pages.

## Features

- 🎨 Minimal brutalist design with clean typography
- 📝 Blog with markdown support
- 📚 Footnotes with hover preview
- 📖 Bibliography and citation system
- 📧 Newsletter subscription (Buttondown)
- 🚀 Automatic deployment via GitHub Actions

## Local Development

### Prerequisites

- [Hugo Extended](https://gohugo.io/installation/) (v0.155.3 or later)

### Running Locally

```bash
# Clone the repository
git clone https://github.com/[your-username]/[your-username].github.io.git
cd [your-username].github.io

# Start the Hugo development server
hugo server -D

# Visit http://localhost:1313
```

## Content Management

### Creating a New Blog Post

```bash
# Create a new post using the archetype template
hugo new blog/posts/my-new-post.md

# Edit the file in content/blog/posts/my-new-post.md
# Set draft: false when ready to publish
# Commit and push to deploy
```

### Using Footnotes

```markdown
This is text with a footnote.[^1]

[^1]: This is the footnote content.
```

Footnotes will automatically show in a popup when you hover over them!

### Using Citations

Add citations to your bibliography in `data/bibliography.json`:

```json
{
  "author2025": {
    "author": "Author Name",
    "year": "2025",
    "title": "Paper Title",
    "journal": "Journal Name",
    "doi": "10.1234/example"
  }
}
```

Then cite in your posts:

```markdown
As noted by {{< cite "author2025" >}}, or with a page: {{< cite "author2025" "p. 45" >}}.

At the end of your post:

{{< bibliography >}}
```

## Deployment

The site automatically deploys to GitHub Pages when you push to the `main` branch.

### Setup GitHub Pages

1. Create a repository named `[your-username].github.io`
2. Push this code to the repository
3. Go to Settings → Pages
4. Set Source to "GitHub Actions"
5. The workflow will automatically build and deploy

Your site will be available at `https://[your-username].github.io`

## Configuration

Edit `hugo.toml` to customize:

- `baseURL`: Your site URL
- `title`: Your site title
- `params.author`: Your name
- `params.description`: Site description

### Newsletter Setup

1. Sign up at [Buttondown](https://buttondown.email)
2. Get your username
3. Edit `layouts/partials/newsletter.html`
4. Replace `[your-username]` with your Buttondown username

## File Structure

```
.
├── .github/workflows/    # GitHub Actions deployment
├── archetypes/          # Content templates
├── content/             # All site content (markdown)
│   ├── bio/
│   ├── blog/
│   └── research/
├── data/                # Bibliography and data files
├── layouts/             # HTML templates
│   ├── _default/
│   ├── partials/
│   └── shortcodes/
├── static/              # Static files (CSS, JS)
│   ├── css/
│   └── js/
└── hugo.toml            # Hugo configuration
```

## Customization

### Design

Edit `static/css/style.css` to customize the brutalist design. The design principles:

- System fonts (Georgia for body, Courier for code)
- Black and white color scheme
- Clean borders and simple shapes
- Maximum readability

### Content

- **Homepage**: `content/_index.md`
- **Bio**: `content/bio/index.md`
- **Research**: `content/research/index.md`
- **Blog posts**: `content/blog/posts/`

## License

[Your chosen license]

## Contact

[Your contact information]
