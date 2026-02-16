# Newsletter Testing Guide

This guide helps you test the email subscription and newsletter functionality.

## Prerequisites

1. **Create .env file**:
   ```bash
   cp .env.example .env
   ```

2. **Add your Buttondown API key** to `.env`:
   ```bash
   BUTTONDOWN_API_KEY=your_actual_api_key_here
   ```

   Get your API key from: https://buttondown.email/settings/programming

## Quick Test

Run the automated test script:
```bash
./test-newsletter.sh
```

This will verify:
- ✓ .env file exists and is configured
- ✓ API key is valid
- ✓ Connection to Buttondown API works
- ✓ Newsletter is properly configured

## Full End-to-End Testing

### Test 1: Subscription Form

1. **Start local server**:
   ```bash
   hugo server -D
   ```

2. **Open site**: Visit http://localhost:1313

3. **Subscribe with test email**:
   - Scroll to newsletter signup form
   - Enter a test email (use your own or a disposable email service)
   - Click "Subscribe"
   - You should see: "✓ Thanks for subscribing! Check your email to confirm."

4. **Confirm subscription**:
   - Check the test email inbox
   - Look for confirmation email from Buttondown
   - Click the confirmation link
   - You should see a success message

5. **Verify in dashboard**:
   - Visit: https://buttondown.email/newsletters/daxmavy/subscribers
   - Your test email should appear in the subscribers list

### Test 2: Sending Newsletter

1. **Ensure you have at least one confirmed subscriber** (from Test 1)

2. **Run the newsletter script**:
   ```bash
   ./send-newsletter.sh
   ```

3. **Follow the prompts**:
   - Enter a test message (e.g., "This is a test newsletter")
   - Enter a subject line (e.g., "Test Newsletter")
   - Click "Send"

4. **Check for success**:
   - You should see: "Newsletter sent successfully!"
   - Check your test subscriber's inbox
   - You should receive the newsletter email

5. **Verify in Buttondown**:
   - Visit: https://buttondown.email/newsletters/daxmavy/emails
   - Your sent email should appear in the archive

## Testing on Production Site

After deploying to https://daxmavy.github.io/:

1. **Test subscription form**:
   - Visit https://daxmavy.github.io/
   - Follow same steps as local testing

2. **Verify form submission**:
   - Open browser DevTools (F12)
   - Go to Network tab
   - Submit the form
   - Look for POST request to `buttondown.email/api/emails/embed-subscribe/daxmavy`
   - Should return 200 OK (though you can't read response due to no-cors)

## Troubleshooting

### API Connection Issues

If `test-newsletter.sh` fails:

```bash
# Test API key manually
curl -X GET https://api.buttondown.email/v1/subscribers \
  -H "Authorization: Token YOUR_API_KEY_HERE"
```

Expected response: JSON with subscriber list

### Subscription Form Issues

If form doesn't work:

1. Check browser console for JavaScript errors
2. Verify form action URL: `https://buttondown.email/api/emails/embed-subscribe/daxmavy`
3. Test directly by visiting Buttondown embed page: https://buttondown.email/daxmavy

### Newsletter Script Issues

If `send-newsletter.sh` fails:

1. Ensure `.env` file exists and has valid API key
2. Check that you have `jq` installed: `brew install jq`
3. Verify you have blog posts in `content/blog/posts/` that aren't drafts
4. Check script output for specific error messages

### Email Not Received

If subscriber doesn't get newsletter:

1. Check spam folder
2. Verify subscriber is confirmed (not pending)
3. Check Buttondown email archive to confirm it was sent
4. Check Buttondown delivery logs for bounces

## Testing Tips

1. **Use disposable email**: Services like https://temp-mail.org/ for quick tests
2. **Test both modes**: Subscribe in both light and dark mode
3. **Test mobile**: Check form works on mobile devices
4. **Test different browsers**: Chrome, Firefox, Safari
5. **Monitor Buttondown dashboard**: https://buttondown.email/newsletters/daxmavy

## Expected Behavior

### Subscription Flow
1. User enters email → Form shows "Subscribing..."
2. Submission completes → Form shows "✓ Thanks for subscribing! Check your email to confirm."
3. Email input clears
4. Button briefly shows "Subscribed!" then resets to "Subscribe"
5. Confirmation email sent to subscriber
6. Subscriber clicks link → Subscription confirmed

### Newsletter Flow
1. Run script → Dialog asks for message
2. Enter message → Dialog asks for subject
3. Enter subject → Script finds recent posts, builds email, sends via API
4. Success → "Newsletter sent successfully!" dialog
5. All confirmed subscribers receive email with:
   - Your custom message
   - List of 3 most recent blog posts (excluding drafts)
   - Unsubscribe link

## Monitoring

Keep an eye on:
- **Subscriber count**: https://buttondown.email/newsletters/daxmavy/subscribers
- **Email archive**: https://buttondown.email/newsletters/daxmavy/emails
- **Analytics**: https://buttondown.email/newsletters/daxmavy/analytics

## Security Notes

- Never commit `.env` file (already in `.gitignore`)
- Keep API key secret
- Only share newsletter script with trusted users
- Regularly review subscriber list for suspicious entries
