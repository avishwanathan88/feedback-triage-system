# ✅ Feedback Triage System - Setup Checklist

Use this checklist to track your progress setting up the feedback triage system.

## 📦 Prerequisites

- [ ] GitHub account created and verified
- [ ] Git installed and configured locally
- [ ] Goose CLI installed (`goose --version` works)
- [ ] OpenRouter API key obtained (or other LLM provider)
- [ ] GitHub CLI installed (optional but recommended)

## 🏗️ Repository Setup

- [ ] Created GitHub repository `feedback-triage-system`
- [ ] Repository is public (or private with Actions enabled)
- [ ] Initialized local git repository
- [ ] Added remote origin
- [ ] Pushed all files to GitHub
- [ ] Verified all files appear on GitHub

## 🔐 Configuration

- [ ] Added `OPENROUTER_API_KEY` as GitHub Secret
- [ ] Verified secret name is exactly correct
- [ ] Confirmed API key has available credits
- [ ] Enabled GitHub Actions in repository settings

## 🏷️ Label Setup

- [ ] Created all category labels (bug, feature, question, urgent, etc.)
- [ ] Created all priority labels (high, medium, low)
- [ ] Created all status labels (needs-triage, needs-review, etc.)
- [ ] Created all area labels (venue, food-beverages, etc.)
- [ ] Verified labels appear in Issues → Labels

**Quick Label Count:** You should have ~19 labels total

## 📋 Issue Templates

- [ ] Bug report template exists
- [ ] Feature request template exists
- [ ] Festival feedback template exists
- [ ] Template config file exists
- [ ] Templates appear when creating new issue

## 🤖 GitHub Actions Workflows

- [ ] Triage workflow file exists (`.github/workflows/triage-feedback.yml`)
- [ ] Welcome workflow file exists (`.github/workflows/welcome.yml`)
- [ ] Workflows appear in Actions tab
- [ ] Workflows are enabled (not disabled)

## 🧪 Testing - Must Have Requirements

### Requirement 1: GitHub Repository Created ✓
- [ ] Repository exists on GitHub
- [ ] Named `feedback-triage-system` or similar
- [ ] All files successfully pushed

### Requirement 2: GitHub Actions Workflow ⚙️
- [ ] Workflow triggers on new issues
- [ ] Workflow file properly configured
- [ ] Workflow appears in Actions tab

### Requirement 3: Goose Integration 🤖
- [ ] Workflow runs goose for analysis
- [ ] API key properly configured
- [ ] Goose successfully analyzes issues

### Requirement 4: API Key as Secret 🔑
- [ ] `OPENROUTER_API_KEY` added as GitHub Secret
- [ ] Secret accessible by workflow
- [ ] No errors in workflow logs

### Requirement 5: Test Issues Created 🏷️
- [ ] **Issue 1:** Sound System Problem (urgent)
  - [ ] Created
  - [ ] Automatically triaged by Goose
  - [ ] Has labels applied
  - [ ] Has AI comment
  
- [ ] **Issue 2:** Food Truck Variety (feature)
  - [ ] Created
  - [ ] Automatically triaged by Goose
  - [ ] Has labels applied
  - [ ] Has AI comment
  
- [ ] **Issue 3:** Accessibility Praise (positive)
  - [ ] Created
  - [ ] Automatically triaged by Goose
  - [ ] Has labels applied
  - [ ] Has AI comment

### Requirement 6: Proper Labeling ✨
- [ ] Issue 1 has `urgent` label
- [ ] Issue 2 has `feature` label
- [ ] Issue 3 has `positive` label
- [ ] All issues have priority labels
- [ ] All issues have category labels

### Requirement 7: AI Comments 💬
- [ ] Issue 1 has Goose comment
- [ ] Issue 2 has Goose comment
- [ ] Issue 3 has Goose comment
- [ ] Comments are helpful and relevant
- [ ] Comments include emoji

## 🌟 Bonus Features

### Priority Levels
- [ ] High priority label created
- [ ] Medium priority label created
- [ ] Low priority label created
- [ ] Issues assigned correct priorities
- [ ] Priority appears in triage comments

### Emoji in Comments
- [ ] AI comments include relevant emoji
- [ ] Emoji enhance readability
- [ ] Different emoji for different issue types

### Issue Templates
- [ ] Bug report template created
- [ ] Feature request template created
- [ ] Festival feedback template created
- [ ] Templates include helpful guidance
- [ ] Dropdown menus work correctly

### Welcome Messages
- [ ] Welcome workflow exists
- [ ] First-time contributors get welcome message
- [ ] Welcome message is friendly and helpful
- [ ] Welcome message mentions AI triage

## 🎯 Validation

Run through this validation sequence:

1. **Create New Issue**
   - [ ] Go to repository Issues tab
   - [ ] Click "New Issue"
   - [ ] Templates appear

2. **Submit Test Issue**
   - [ ] Fill out festival feedback template
   - [ ] Submit issue
   - [ ] Issue appears in list

3. **Watch Workflow**
   - [ ] Go to Actions tab
   - [ ] Workflow appears and runs
   - [ ] No errors in workflow
   - [ ] Workflow completes successfully

4. **Verify Triage**
   - [ ] Return to issue
   - [ ] Goose comment appears
   - [ ] Labels are applied
   - [ ] Comment is relevant to issue content

5. **Check All Three Issues**
   - [ ] All three test issues created
   - [ ] All three automatically triaged
   - [ ] Different labels for different types
   - [ ] Appropriate priorities assigned

## 📊 Success Metrics

Count your successes:

- **Issues Created:** ___ / 3
- **Issues Triaged:** ___ / 3
- **Proper Labels:** ___ / 3
- **AI Comments:** ___ / 3
- **Correct Priority:** ___ / 3

**Total Score:** ___ / 15

🎉 **Success = 15/15!**

## 🐛 Troubleshooting Log

If something isn't working, track it here:

**Issue:**
- Problem: ___________
- Error message: ___________
- Solution attempted: ___________
- Result: ___________

## 📝 Notes

Add any observations or customizations here:

---

## 🎓 Next Steps After Completion

Once all checkboxes are complete:

- [ ] Share repository with team members
- [ ] Set up GitHub Projects for organization
- [ ] Customize triage logic for your needs
- [ ] Add more label categories
- [ ] Create custom issue templates
- [ ] Set up notifications
- [ ] Document your process
- [ ] Start collecting real feedback!

## 🏆 Certification

When complete, you can certify your system:

**I certify that:**
- ✅ All must-have requirements are met
- ✅ All three test issues were successfully triaged
- ✅ Goose automatically analyzes and labels issues
- ✅ The system is ready for production use

**Date:** __________
**Your Name:** __________

---

**Congratulations! 🎉 Your Feedback Triage System is live! 🤖**
