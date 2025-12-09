# 🚀 Complete Setup Guide

Follow these steps to set up your Feedback Triage System with GitHub and Goose.

## Step 1: Create GitHub Repository

### Option A: Using GitHub Web Interface

1. Go to https://github.com/new
2. Repository name: `feedback-triage-system`
3. Description: `Automated feedback triage system powered by Goose AI`
4. Choose **Public** or **Private**
5. **DO NOT** initialize with README (we already have one)
6. Click **Create repository**

### Option B: Using GitHub CLI (if installed)

```bash
gh repo create feedback-triage-system --public --description "Automated feedback triage system powered by Goose AI"
```

## Step 2: Push Local Repository to GitHub

After creating the repository on GitHub, you'll see instructions. Run these commands:

```bash
cd /Users/avishwan/feedback-triage-system

# Add all files
git add .

# Commit
git commit -m "Initial commit: Feedback triage system with Goose AI"

# Add remote (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/feedback-triage-system.git

# Push to GitHub
git branch -M main
git push -u origin main
```

## Step 3: Configure GitHub Secrets

You need to add your OpenRouter API key as a GitHub Secret:

1. Go to your repository on GitHub
2. Click **Settings** (top menu)
3. In the left sidebar, click **Secrets and variables** → **Actions**
4. Click **New repository secret**
5. Add this secret:
   - **Name:** `OPENROUTER_API_KEY`
   - **Value:** Your OpenRouter API key
6. Click **Add secret**

**Note:** The `GITHUB_TOKEN` is automatically provided by GitHub Actions, no need to add it.

## Step 4: Enable GitHub Actions

1. Go to the **Actions** tab in your repository
2. If prompted, click **I understand my workflows, go ahead and enable them**
3. You should see two workflows:
   - 🤖 Feedback Triage with Goose
   - 👋 Welcome First-Time Contributors

## Step 5: Set Up GitHub MCP Extension (Optional but Recommended)

To enable GitHub integration in Goose for local development:

1. Install the GitHub MCP extension for Goose:
   ```bash
   # Check available extensions
   goose extension search github
   
   # Install GitHub extension
   goose extension install github-mcp
   ```

2. Configure GitHub authentication:
   - Create a GitHub Personal Access Token:
     - Go to https://github.com/settings/tokens
     - Click **Generate new token (classic)**
     - Select scopes: `repo`, `workflow`, `write:discussion`
     - Click **Generate token**
     - Copy the token
   
3. Add to Goose config (if needed):
   ```bash
   # The extension should guide you through authentication
   ```

## Step 6: Create Label Structure

Go to your repository → Issues → Labels and create these labels:

### Category Labels
- 🐛 `bug` (red: #d73a4a)
- ✨ `feature` (green: #a2eeef)
- ❓ `question` (purple: #d876e3)
- 🚨 `urgent` (dark red: #b60205)
- 📚 `documentation` (blue: #0075ca)
- 🎉 `festival-feedback` (yellow: #fbca04)
- ✅ `positive` (light green: #7FD87A)

### Priority Labels
- 🔴 `priority: high` (red: #d73a4a)
- 🟡 `priority: medium` (yellow: #fbca04)
- 🟢 `priority: low` (green: #0e8a16)

### Status Labels
- 🔍 `needs-triage` (gray: #d4c5f9)
- 👀 `needs-review` (light blue: #5EBEFF)
- 🚧 `in-progress` (orange: #FFA500)
- ✅ `resolved` (green: #0e8a16)

### Area Labels
- 🏟️ `venue` (blue: #1d76db)
- 🍔 `food-beverages` (orange: #f9d0c4)
- 🎵 `entertainment` (purple: #8250df)
- ♿ `accessibility` (teal: #39d5c5)
- 👥 `staff` (pink: #ff69b4)

**Quick way to create labels:**

Use GitHub's label management or run this script (requires GitHub CLI):

```bash
# Save this as create_labels.sh and run: bash create_labels.sh

REPO="YOUR_USERNAME/feedback-triage-system"

# Category Labels
gh label create "bug" --color "d73a4a" --description "Something isn't working" --repo $REPO
gh label create "feature" --color "a2eeef" --description "New feature or request" --repo $REPO
gh label create "question" --color "d876e3" --description "Further information requested" --repo $REPO
gh label create "urgent" --color "b60205" --description "Requires immediate attention" --repo $REPO
gh label create "documentation" --color "0075ca" --description "Documentation improvements" --repo $REPO
gh label create "festival-feedback" --color "fbca04" --description "Festival-specific feedback" --repo $REPO
gh label create "positive" --color "7FD87A" --description "Positive feedback" --repo $REPO

# Priority Labels
gh label create "priority: high" --color "d73a4a" --description "High priority" --repo $REPO
gh label create "priority: medium" --color "fbca04" --description "Medium priority" --repo $REPO
gh label create "priority: low" --color "0e8a16" --description "Low priority" --repo $REPO

# Status Labels
gh label create "needs-triage" --color "d4c5f9" --description "Waiting for triage" --repo $REPO
gh label create "needs-review" --color "5EBEFF" --description "Needs team review" --repo $REPO
gh label create "in-progress" --color "FFA500" --description "Currently being worked on" --repo $REPO
gh label create "resolved" --color "0e8a16" --description "Issue resolved" --repo $REPO

# Area Labels
gh label create "venue" --color "1d76db" --description "Venue related" --repo $REPO
gh label create "food-beverages" --color "f9d0c4" --description "Food and beverages" --repo $REPO
gh label create "entertainment" --color "8250df" --description "Entertainment related" --repo $REPO
gh label create "accessibility" --color "39d5c5" --description "Accessibility related" --repo $REPO
gh label create "staff" --color "ff69b4" --description "Staff related" --repo $REPO
```

## Step 7: Test the System

Create your first test issue:

1. Go to **Issues** → **New Issue**
2. Select **🎉 Festival Feedback** template
3. Use one of the sample feedback items from `SAMPLE_FEEDBACK.md`
4. Submit the issue
5. Go to **Actions** tab to watch the workflow run
6. Return to the issue to see Goose's analysis! 🤖

## Step 8: Create All Three Test Issues

Create issues for all three sample feedback items:

1. **Sound System Problem** (should be tagged as urgent/high priority)
2. **Food Truck Variety** (should be tagged as feature/medium priority)
3. **Parking and Accessibility** (should be tagged as positive/low priority)

## Troubleshooting

### Workflow not triggering?
- Check that GitHub Actions are enabled in Settings
- Ensure the workflow file is in `.github/workflows/`
- Check the Actions tab for error messages

### API key issues?
- Verify the secret is named exactly `OPENROUTER_API_KEY`
- Make sure the key is valid and has credits
- Check workflow logs for specific error messages

### Labels not applying?
- Ensure labels are created in the repository
- Check that label names match exactly (case-sensitive)
- Review the workflow logs for errors

### Goose not analyzing correctly?
- Check the `scripts/triage.sh` script
- Verify Goose installation in the workflow
- Review the analysis prompt in the script

## Next Steps

After successful setup:

1. ✅ Monitor the Actions tab to see workflows run
2. ✅ Create more test issues
3. ✅ Customize the triage logic in `scripts/triage.sh`
4. ✅ Adjust issue templates for your needs
5. ✅ Share the repository with your team
6. ✅ Start collecting real feedback!

## Additional Resources

- [Goose Documentation](https://github.com/block/goose)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [OpenRouter API](https://openrouter.ai/)
- [GitHub Issue Templates](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests)

## Support

If you encounter issues:

1. Check the Actions tab for workflow logs
2. Review the troubleshooting section above
3. Create an issue in this repository (it will be auto-triaged! 😄)
4. Check Goose community resources

---

**You're all set! 🎉 Happy triaging! 🤖**
