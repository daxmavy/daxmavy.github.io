#!/bin/bash

# Newsletter Testing Script
# This script helps verify your Buttondown integration is working

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "=== Buttondown Newsletter Test ==="
echo ""

# Load environment variables from .env
if [ -f "$SCRIPT_DIR/.env" ]; then
    export $(cat "$SCRIPT_DIR/.env" | grep -v '^#' | xargs)
    echo "✓ Loaded .env file"
else
    echo "✗ Error: .env file not found!"
    echo "  Please copy .env.example to .env and add your API key"
    exit 1
fi

# Check if API key is set
if [ -z "$BUTTONDOWN_API_KEY" ] || [ "$BUTTONDOWN_API_KEY" = "your_api_key_here" ]; then
    echo "✗ Error: BUTTONDOWN_API_KEY not configured"
    echo "  Please add your API key to the .env file"
    exit 1
fi

echo "✓ API key found"
echo ""

# Test 1: Check API connection
echo "Test 1: Checking API connection..."
RESPONSE=$(curl -s -w "\n%{http_code}" -X GET https://api.buttondown.email/v1/subscribers \
  -H "Authorization: Token ${BUTTONDOWN_API_KEY}")

HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
BODY=$(echo "$RESPONSE" | sed '$d')

if [ "$HTTP_CODE" = "200" ]; then
    echo "✓ API connection successful"
    SUBSCRIBER_COUNT=$(echo "$BODY" | grep -o '"count":[0-9]*' | grep -o '[0-9]*')
    echo "  Current subscribers: ${SUBSCRIBER_COUNT:-0}"
else
    echo "✗ API connection failed (HTTP $HTTP_CODE)"
    echo "  Response: $BODY"
    exit 1
fi

echo ""

# Test 2: Check newsletter configuration
echo "Test 2: Checking newsletter configuration..."
NEWSLETTER_INFO=$(curl -s -X GET https://api.buttondown.email/v1/newsletters/daxmavy \
  -H "Authorization: Token ${BUTTONDOWN_API_KEY}")

if echo "$NEWSLETTER_INFO" | grep -q '"username"'; then
    echo "✓ Newsletter found: daxmavy"
    NAME=$(echo "$NEWSLETTER_INFO" | grep -o '"name":"[^"]*"' | cut -d'"' -f4)
    echo "  Name: ${NAME}"
else
    echo "✗ Newsletter not found or API error"
    echo "  Response: $NEWSLETTER_INFO"
fi

echo ""
echo "=== Test Complete ==="
echo ""
echo "Next steps to test full functionality:"
echo ""
echo "1. Test subscription form:"
echo "   - Visit https://daxmavy.github.io/"
echo "   - Enter a test email address"
echo "   - Check email for confirmation link"
echo "   - Click confirmation link"
echo ""
echo "2. Test sending newsletter:"
echo "   - Run: ./send-newsletter.sh"
echo "   - Enter a test message"
echo "   - Check your test email inbox"
echo ""
echo "3. Monitor in Buttondown dashboard:"
echo "   - Visit: https://buttondown.email/newsletters/daxmavy"
echo "   - Check subscribers list"
echo "   - View sent emails archive"
echo ""
