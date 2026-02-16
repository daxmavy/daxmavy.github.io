# Bibliography Guide

The `data/bibliography.json` file is used with Hugo shortcodes to automatically format citations and reference lists in your blog posts and pages.

## How It Works

1. **Add entries to `data/bibliography.json`** - Define your publications once
2. **Use shortcodes in markdown files** - Reference them anywhere
3. **Hugo renders formatted citations** - Consistent styling across your site

## Adding Publications

Edit `data/bibliography.json` and add entries with a unique key:

```json
{
  "davy2026dsa": {
    "author": "Davy, M.",
    "year": "2026",
    "title": "The Missing Metrics in DSA Content Moderation Transparency",
    "journal": "DSA Observatory",
    "url": "https://dsa-observatory.eu/2026/01/08/...",
    "abstract": "Analysis of the Digital Services Act's transparency requirements..."
  },
  "maghsudi2021": {
    "author": "Maghsudi, S. & Davy, M.",
    "year": "2021",
    "title": "Computational Models of Human Decision-Making",
    "journal": "IEEE Wireless Communications",
    "volume": "28",
    "issue": "1",
    "pages": "152-159",
    "doi": "10.1109/MWC.001.2000250"
  }
}
```

## Available Fields

- `author` - Author name(s) (required)
- `year` - Publication year (required)
- `title` - Paper title (required)
- `journal` - Journal name (optional)
- `volume` - Journal volume (optional)
- `issue` - Journal issue (optional)
- `pages` - Page numbers (optional)
- `publisher` - Publisher name (optional, for books)
- `doi` - DOI identifier (optional)
- `url` - URL to publication (optional)
- `pdf` - Link to PDF file (optional)
- `abstract` - Full abstract text (optional, will be collapsible)

## Using in Markdown

### Method 1: Full Bibliography

Show all entries from bibliography.json:

```markdown
# References

{{< bibliography >}}
```

### Method 2: In-text Citation

Cite a specific paper inline:

```markdown
According to recent research {{< cite "davy2026dsa" >}}, the DSA needs better metrics.
```

This will render as: "According to recent research (Davy, 2026), the DSA needs better metrics."

### Method 3: Mixed Usage

```markdown
# My Blog Post

Recent work on content moderation {{< cite "davy2026dsa" >}} has shown that
transparency requirements need improvement. Other research {{< cite "maghsudi2021" >}}
explores human decision-making in IoT systems.

## References

{{< bibliography >}}
```

## Example in Action

Create a blog post at `content/blog/posts/my-research.md`:

```markdown
---
title: "My Research Overview"
date: 2026-02-16
---

My recent work {{< cite "davy2026dsa" >}} examines DSA transparency metrics.

## Full Bibliography

{{< bibliography >}}
```

## Styling

The bibliography is styled using CSS classes in `static/css/style.css`:

- `.bibliography` - Container for entire bibliography
- `.publication-item` - Each publication entry
- `.pub-title` - Publication title
- `.pub-authors` - Author names
- `.pub-venue` - Journal/venue information
- `.pub-links` - DOI, URL, PDF links
- `.publication-abstract` - Collapsible abstract section

## Current System vs New System

You now have **two ways** to show research:

### 1. Research Page (New Template System)
- File: `content/research/index.md`
- Uses: Frontmatter YAML
- Best for: Structured research showcase
- Features: Collapsible abstracts, venues, ongoing projects

### 2. Bibliography Shortcode (Original System)
- File: `data/bibliography.json`
- Uses: JSON + shortcodes in markdown
- Best for: Citation in blog posts, automatic reference lists
- Features: In-text citations, formatted references

## Which Should You Use?

**Research Page** - Use for your main research showcase at `/research/`
- Easier to maintain (YAML in markdown)
- Better for project descriptions
- Shows current work and publications together

**Bibliography System** - Use for blog posts that cite papers
- Cite papers inline: `{{< cite "key" >}}`
- Generate reference lists automatically
- Maintain single source of truth for publication data

## Migration Tip

You can keep both! Use the research page template for your main showcase, and
use bibliography.json for citing papers in blog posts. They serve different purposes.

## Example: Citing in a Blog Post

Create `content/blog/posts/llm-bias.md`:

```markdown
---
title: "Understanding LLM Bias"
date: 2026-02-16
---

Large language models exhibit various forms of bias. My thesis work explores
how these biases disproportionately affect minority political perspectives.

This builds on prior work in computational decision-making {{< cite "maghsudi2021" >}}
and considers regulatory frameworks like the DSA {{< cite "davy2026dsa" >}}.

## References

{{< bibliography >}}
```

This will automatically format citations and generate a full reference list at the bottom!
