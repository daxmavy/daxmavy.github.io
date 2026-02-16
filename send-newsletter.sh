#!/bin/bash

# Buttondown Newsletter Sender
# Usage: ./send-newsletter.sh

set -e

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Load environment variables from .env
if [ -f "$SCRIPT_DIR/.env" ]; then
    export $(cat "$SCRIPT_DIR/.env" | grep -v '^#' | xargs)
else
    osascript -e 'display dialog "Error: .env file not found!\n\nPlease copy .env.example to .env and add your Buttondown API key." buttons {"OK"} default button "OK" with icon stop'
    echo "Error: .env file not found. Please copy .env.example to .env and add your API key."
    exit 1
fi

# Check if API key is set
if [ -z "$BUTTONDOWN_API_KEY" ] || [ "$BUTTONDOWN_API_KEY" = "your_api_key_here" ]; then
    osascript -e 'display dialog "Please add your Buttondown API key to the .env file!" buttons {"OK"} default button "OK" with icon stop'
    exit 1
fi

# Configuration
SITE_URL="https://daxmavy.github.io"

# Get latest blog posts (last 3, excluding drafts)
echo "Finding recent blog posts..."
RECENT_POSTS=$(find content/blog/posts -name "*.md" -not -name "_index.md" |
    while read -r post; do
        # Check if draft
        if grep -q "^draft: true" "$post" 2>/dev/null; then
            continue
        fi
        echo "$post"
    done |
    grep -v "ethical-ai" |
    sort -r |
    head -n 3)

# Build post list
POST_LIST=""
for post in $RECENT_POSTS; do
    # Extract title from frontmatter
    TITLE=$(grep "^title:" "$post" | sed 's/title: *"\(.*\)"/\1/' | sed "s/title: *'\(.*\)'/\1/")
    # Get filename for URL
    FILENAME=$(basename "$post" .md)
    URL="${SITE_URL}/blog/posts/${FILENAME}/"

    POST_LIST="${POST_LIST}- [${TITLE}](${URL})\n"
done

# Get custom message from user
MESSAGE=$(osascript -e 'Tell application "System Events" to display dialog "Enter newsletter message/description:" default answer "" with title "Newsletter Description" buttons {"Cancel", "Send"} default button "Send"' -e 'text returned of result' 2>/dev/null)

if [ $? -ne 0 ] || [ -z "$MESSAGE" ]; then
    echo "Cancelled."
    exit 0
fi

# Create email body
EMAIL_BODY=$(cat <<EOF
${MESSAGE}

## Recent Posts

${POST_LIST}

---

*You're receiving this because you subscribed to updates from Max Davy. [Unsubscribe](https://buttondown.email/unsubscribe)*
EOF
)

# Get subject from user
SUBJECT=$(osascript -e 'Tell application "System Events" to display dialog "Email subject line:" default answer "New posts from Max Davy" with title "Newsletter Subject" buttons {"Cancel", "Send"} default button "Send"' -e 'text returned of result' 2>/dev/null)

if [ $? -ne 0 ] || [ -z "$SUBJECT" ]; then
    echo "Cancelled."
    exit 0
fi

echo "Sending newsletter..."

# Send via Buttondown API
RESPONSE=$(curl -s -X POST https://api.buttondown.email/v1/emails \
  -H "Authorization: Token ${BUTTONDOWN_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"subject\": \"${SUBJECT}\",
    \"body\": $(echo "$EMAIL_BODY" | jq -Rs .),
    \"email_type\": \"public\"
  }")

# Check response
if echo "$RESPONSE" | grep -q "\"id\""; then
    osascript -e 'display dialog "✓ Newsletter sent successfully!" buttons {"OK"} default button "OK"'
    echo "Success! Newsletter sent."
else
    echo "Error: $RESPONSE"
    osascript -e "display dialog \"Error sending newsletter. Check terminal for details.\" buttons {\"OK\"} default button \"OK\" with icon stop"
    exit 1
fi
