#!/bin/bash

# Buttondown Newsletter Sender
# Usage: ./send-newsletter.sh

set -e

# Configuration
BUTTONDOWN_API_KEY="your-api-key-here"
SITE_URL="https://daxmavy.github.io"

# Check if API key is set
if [ "$BUTTONDOWN_API_KEY" = "your-api-key-here" ]; then
    osascript -e 'display dialog "Please edit send-newsletter.sh and add your Buttondown API key!" buttons {"OK"} default button "OK" with icon stop'
    exit 1
fi

# Get latest blog posts (last 3)
echo "Finding recent blog posts..."
RECENT_POSTS=$(find content/blog/posts -name "*.md" -not -name "_index.md" |
    grep -v "ethical-ai" |
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
