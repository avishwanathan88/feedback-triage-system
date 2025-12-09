# ⚡ Quick Start Guide

Get your Feedback Triage System up and running in 10 minutes!

## 📋 Prerequisites Checklist

- ✅ GitHub account
- ✅ Goose CLI installed
- ✅ OpenRouter API key (or other LLM provider key)
- ⬜ Git configured locally

## 🚀 5-Step Setup

### Step 1: Create GitHub Repository (2 min)

**Option A - Web Interface:**
1. Go to https://github.com/new
2. Name: `feedback-triage-system`
3. Make it **Public**
4. **Don't** initialize with README
5. Click "Create repository"

**Option B - Command Line (if you have GitHub CLI):**
```bash
gh repo create feedback-triage-system --public --description "Automated feedback triage with Goose AI"
```

### Step 2: Push Code to GitHub (1 min)

```bash
cd /Users/avishwan/feedback-triage-system

# Add and commit all files
git add .
git commit -m "🚀 Initial commit: Feedback triage system with Goose AI"

# Replace YOUR_USERNAME with your GitHub username
git remote add origin https://github.com/YOUR_USERNAME/feedback-triage-system.git

# Push to GitHub
git branch -M main
git push -u origin main
```

### Step 3: Add API Key Secret (2 min)

1. Go to your repository on GitHub
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Name: `OPENROUTER_API_KEY`
5. Value: [Paste your OpenRouter API key]
6. Click **Add secret**

### Step 4: Create Labels (2 min)

**Option A - Using the script (if you have GitHub CLI):**
```bash
# Replace YOUR_USERNAME with your GitHub username
./scripts/create_labels.sh YOUR_USERNAME/feedback-triage-system
```

**Option B - Manually:**
1. Go to your repo → **Issues** → **Labels**
2. Create these essential labels:

| Label | Color | Description |
|-------|-------|-------------|
| `bug` | #d73a4a | Something isn't working |
| `feature` | #a2eeef | New feature request |
| `urgent` | #b60205 | Needs immediate attention |
| `festival-feedback` | #fbca04 | Festival feedback |
| `priority: high` | #d73a4a | High priority |
| `priority: medium` | #fbca04 | Medium priority |
| `priority: low` | #0e8a16 | Low priority |
| `needs-triage` | #d4c5f9 | Awaiting triage |

### Step 5: Test with Sample Issues (3 min)

1. Go to **Issues** → **New Issue**
2. Select **🎉 Festival Feedback**
3. Copy content from `SAMPLE_FEEDBACK.md` (Sample Issue 1)
4. Submit
5. Go to **Actions** tab to watch it run! 🤖
6. Return to your issue to see Goose's comment!

Repeat for all 3 sample issues to test different scenarios.

## 🎯 What to Expect

When you create an issue:

1. **Immediately:** Welcome message appears (for first-time contributors)
2. **Within 1-2 min:** GitHub Actions workflow starts
3. **After 2-3 min:** Goose analyzes the issue
4. **Result:** Issue gets:
   - ✨ Helpful AI-generated comment
   - 🏷️ Automatic labels
   - 📊 Priority assignment

## 🧪 Testing Checklist

Create these 3 test issues from `SAMPLE_FEEDBACK.md`:

- [ ] **Issue 1:** Sound System Problem → Should get `urgent` + `priority: high`
- [ ] **Issue 2:** Food Truck Variety → Should get `feature` + `priority: medium`
- [ ] **Issue 3:** Accessibility Praise → Should get `positive` + `priority: low`

## 🎉 Success Criteria

✅ **Your system is working when:**

- Repository created and code pushed
- Secrets configured
- Labels created
- 3 test issues created
- All 3 issues automatically triaged by Goose
- Each issue has:
  - AI comment with emoji
  - Appropriate labels
  - Priority assigned

## 🔧 Troubleshooting

### "Workflow not running"
- Check Actions tab is enabled (Settings → Actions → Enable)
- Verify `.github/workflows/` files are pushed

### "Goose analysis failed"
- Verify `OPENROUTER_API_KEY` secret is set correctly
- Check your API key has credits
- View workflow logs in Actions tab

### "Labels not applying"
- Ensure labels exist in your repo
- Check label names match exactly (case-sensitive)
- Review workflow logs for errors

## 📱 Quick Commands Reference

```bash
# View workflow logs (requires GitHub CLI)
gh run list --repo YOUR_USERNAME/feedback-triage-system

# Create an issue from CLI
gh issue create --repo YOUR_USERNAME/feedback-triage-system --title "Test" --body "Testing"

# View all issues
gh issue list --repo YOUR_USERNAME/feedback-triage-system
```

## 🎓 Next Steps

After successful setup:

1. 📝 Customize issue templates in `.github/ISSUE_TEMPLATE/`
2. 🤖 Adjust triage logic in `scripts/triage.sh`
3. 🏷️ Add more custom labels for your needs
4. 📊 Set up GitHub Projects for better organization
5. 👥 Invite team members as collaborators
6. 🔔 Configure notification preferences

## 📚 Additional Resources

- **Full Setup Guide:** See `SETUP_GUIDE.md` for detailed instructions
- **Sample Feedback:** See `SAMPLE_FEEDBACK.md` for test data
- **Main README:** See `README.md` for complete documentation

## 💡 Tips

- Start with public repo to avoid GitHub Actions minutes limits
- Test with sample feedback first before using real data
- Monitor the Actions tab for the first few runs
- Adjust the AI prompt in `triage.sh` to match your needs
- Add team members to help with manual review

## 🆘 Need Help?

1. Check workflow logs in the Actions tab
2. Review `SETUP_GUIDE.md` for detailed steps
3. Create an issue in this repo (it will be auto-triaged! 😄)
4. Check [Goose documentation](https://github.com/block/goose)

---

**Ready? Let's go! 🚀**

Time to create your first auto-triaged issue!
