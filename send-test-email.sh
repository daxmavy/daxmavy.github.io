#!/bin/bash

# Quick test email sender
# Sends a simple test email to verify Buttondown integration

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}\" )" && pwd )"

# Load environment variables from .env
if [ -f "$SCRIPT_DIR/.env" ]; then
    export $(cat "$SCRIPT_DIR/.env" | grep -v '^#' | xargs)
else
    echo "Error: .env file not found!"
    exit 1
fi

if [ -z "$BUTTONDOWN_API_KEY" ] || [ "$BUTTONDOWN_API_KEY" = "your_api_key_here" ]; then
    echo "Error: Please add your Buttondown API key to the .env file"
    exit 1
fi

echo "Sending test email to all subscribers..."

# Simple test email
RESPONSE=$(curl -s -X POST https://api.buttondown.email/v1/emails \
  -H "Authorization: Token ${BUTTONDOWN_API_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "subject": "Test Email from Max Davy",
    "body": "This is a test email to verify the newsletter integration is working correctly.\n\nIf you received this, everything is set up properly!\n\n---\n\n*You'\''re receiving this because you subscribed to updates from Max Davy. [Unsubscribe](https://buttondown.email/unsubscribe)*",
    "email_type": "public"
  }')

# Check response
if echo "$RESPONSE" | grep -q '"id"'; then
    EMAIL_ID=$(echo "$RESPONSE" | grep -o '"id":"[^"]*"' | cut -d'"' -f4)
    echo "✓ Test email sent successfully!"
    echo "  Email ID: $EMAIL_ID"
    echo ""
    echo "Check your subscriber inbox(es) in a few moments."
    echo "View in Buttondown: https://buttondown.email/newsletters/daxmavy/emails"
else
    echo "✗ Error sending email:"
    echo "$RESPONSE"
    exit 1
fi
