# 🔧 GitHub MCP Extension Setup (Optional)

The GitHub MCP extension allows Goose to interact with GitHub directly from your local environment. While **not required** for the feedback triage system to work (since GitHub Actions handles everything), it can be useful for local development and testing.

## Do I Need This?

**For the Feedback Triage System: NO** ❌

The triage system works entirely through GitHub Actions and doesn't require the GitHub MCP extension. The workflow runs in GitHub's cloud environment.

**For Local Development: YES** ✅ (Optional but helpful)

If you want to interact with GitHub from Goose locally (create issues, manage repos, etc.), then the extension is useful.

## How GitHub MCP Would Be Used

If you had GitHub MCP enabled, you could:

- Create GitHub issues from Goose CLI
- Manage repositories
- Add labels programmatically
- Query issue data
- Automate GitHub tasks locally

## Setup Instructions (If You Want It)

### Option 1: Using Goose Extension Manager (If Available)

If the Extension Manager is enabled in your Goose config:

```bash
# Search for GitHub extension
goose extension search github

# Install GitHub MCP extension
goose extension install github-mcp
```

### Option 2: Manual Setup

Since the Extension Manager is currently disabled in your config, you would need to:

1. **Find the GitHub MCP Server**
   - Search at https://block.github.io/goose/v1/extensions/
   - Or check https://github.com/modelcontextprotocol for official servers

2. **Get GitHub Personal Access Token**
   - Go to https://github.com/settings/tokens
   - Click "Generate new token (classic)"
   - Select scopes: `repo`, `workflow`, `write:discussion`
   - Generate and copy the token

3. **Add to Goose Config**
   
   Edit `~/.config/goose/config.yaml`:

   ```yaml
   extensions:
     # ... existing extensions ...
     github:
       enabled: true
       type: streamable_http  # or stdio, depending on the server
       name: GitHub
       description: Interact with GitHub repositories
       uri: [GITHUB_MCP_SERVER_URL]
       envs:
         GITHUB_TOKEN: [YOUR_GITHUB_TOKEN]
       timeout: 300
   ```

## Alternative: Use GitHub CLI Instead

Instead of GitHub MCP, you can use GitHub CLI (`gh`), which is simpler:

```bash
# Install GitHub CLI (you tried this earlier but had network issues)
brew install gh

# Authenticate
gh auth login

# Now you can use gh commands
gh repo create
gh issue create
gh issue list
```

## For This Project

**You don't need GitHub MCP or even GitHub CLI for the feedback triage system to work!**

Everything happens automatically through:
1. GitHub Actions (cloud-based)
2. GitHub web interface (for creating the repo and issues)
3. The triage script runs in GitHub Actions, not locally

## What You DO Need

✅ **Required:**
- GitHub account
- OpenRouter API key (set as GitHub Secret)
- GitHub Actions enabled
- Web browser to access GitHub

❌ **NOT Required:**
- GitHub MCP extension
- GitHub CLI (helpful but optional)
- Local Goose GitHub integration

## When to Set Up GitHub MCP

Consider setting up GitHub MCP if:

- You want to automate GitHub tasks from Goose locally
- You're building other tools that need GitHub integration
- You want to test GitHub operations before deploying

## Current Status

**Your feedback triage system will work WITHOUT GitHub MCP because:**

1. ✅ GitHub Actions runs in the cloud
2. ✅ Goose is installed in the GitHub Actions workflow
3. ✅ API authentication happens via GitHub Secrets
4. ✅ All GitHub operations use GitHub's native API
5. ✅ No local GitHub integration needed

## Summary

| Feature | Requires GitHub MCP? |
|---------|---------------------|
| Create GitHub repository | ❌ No (use web UI) |
| Push code to GitHub | ❌ No (use git) |
| Set GitHub Secrets | ❌ No (use web UI) |
| Create labels | ❌ No (use script with `gh` or web UI) |
| Create issues | ❌ No (use web UI) |
| Auto-triage issues | ❌ No (GitHub Actions handles it) |
| Local GitHub automation | ✅ Yes (but optional) |

## Bottom Line

**You can skip GitHub MCP setup entirely and your feedback triage system will work perfectly!** 🎉

Just follow the steps in `FINAL_STEPS.md` to:
1. Create the repo (web UI)
2. Push code (git)
3. Add API key (web UI)
4. Create labels (web UI or script)
5. Test with issues (web UI)

Everything else is automated via GitHub Actions! 🚀

---

**Need help with actual deployment?** See `FINAL_STEPS.md`

**Questions about the system?** See `README.md` or `QUICK_START.md`
