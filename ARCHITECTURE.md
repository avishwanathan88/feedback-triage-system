# 🏗️ System Architecture

## Overview

The Feedback Triage System uses GitHub Actions and Goose AI to automatically analyze, categorize, and label issues as they are created.

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                         GitHub Repository                        │
│                    feedback-triage-system                       │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ User creates issue
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                       GitHub Issue Created                       │
│  Templates: Bug Report / Feature Request / Festival Feedback    │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ Triggers webhook
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      GitHub Actions Workflow                     │
│                   (.github/workflows/*.yml)                      │
│                                                                   │
│  ┌──────────────────┐    ┌──────────────────┐                  │
│  │ Triage Workflow  │    │ Welcome Workflow │                  │
│  │ (on: issue.open) │    │ (first-time)     │                  │
│  └──────────────────┘    └──────────────────┘                  │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ Runs triage script
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    Triage Script Execution                       │
│                    (scripts/triage.sh)                          │
│                                                                   │
│  1. Setup Goose configuration                                   │
│  2. Extract issue data (title, body, number)                   │
│  3. Create analysis prompt                                      │
│  4. Call Goose CLI                                              │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ Sends prompt
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                         Goose AI Engine                          │
│                                                                   │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │                   LLM Provider                              │ │
│  │              (OpenRouter / Claude / GPT)                    │ │
│  │                                                              │ │
│  │  • Analyzes issue content                                   │ │
│  │  • Determines category (bug/feature/urgent/etc)            │ │
│  │  • Assigns priority (high/medium/low)                      │ │
│  │  • Generates helpful comment with emoji                    │ │
│  │  • Suggests appropriate labels                             │ │
│  └────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ Returns JSON
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      Triage Data Processing                      │
│                                                                   │
│  {                                                               │
│    "category": "urgent",                                        │
│    "priority": "high",                                          │
│    "comment": "🚨 This urgent issue...",                       │
│    "labels": ["urgent", "venue", "priority: high"]            │
│  }                                                               │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ Apply via GitHub API
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      GitHub API Actions                          │
│                                                                   │
│  POST /repos/{owner}/{repo}/issues/{number}/comments            │
│  POST /repos/{owner}/{repo}/issues/{number}/labels              │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ Updates issue
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                     Triaged GitHub Issue                         │
│                                                                   │
│  ✅ AI Comment Added                                            │
│  🏷️ Labels Applied                                             │
│  📊 Priority Assigned                                           │
│  🎉 Ready for Team Review                                       │
└─────────────────────────────────────────────────────────────────┘
```

## Component Details

### 1. Issue Templates

**Location:** `.github/ISSUE_TEMPLATE/`

**Purpose:** Guide users to provide structured feedback

**Templates:**
- `bug_report.yml` - For reporting bugs
- `feature_request.yml` - For suggesting features
- `festival_feedback.yml` - For festival-specific feedback
- `config.yml` - Template configuration

**Features:**
- Dropdown menus for categorization
- Required fields for essential information
- Helpful descriptions and placeholders
- Automatic label assignment

### 2. GitHub Actions Workflows

**Location:** `.github/workflows/`

#### Triage Workflow (`triage-feedback.yml`)

**Trigger:** When an issue is opened or reopened

**Steps:**
1. Checkout repository
2. Install Goose CLI
3. Run triage script with issue data
4. Script applies labels and comments

**Environment Variables:**
- `GITHUB_TOKEN` - Auto-provided by GitHub
- `OPENROUTER_API_KEY` - From repository secrets
- `ISSUE_NUMBER` - From event context
- `ISSUE_TITLE` - From event context
- `ISSUE_BODY` - From event context

#### Welcome Workflow (`welcome.yml`)

**Trigger:** When an issue is opened

**Purpose:** Welcome first-time contributors

**Features:**
- Detects first-time issue creators
- Posts friendly welcome message
- Explains the triage process

### 3. Triage Script

**Location:** `scripts/triage.sh`

**Language:** Bash

**Functions:**
1. **Setup** - Configure Goose environment
2. **Analysis** - Create prompt and run Goose
3. **Parsing** - Extract JSON from Goose output
4. **Application** - Apply labels and comments via GitHub API

**Input:** Environment variables from workflow

**Output:** 
- Comment on issue
- Labels applied to issue
- Log output for debugging

### 4. Goose AI Integration

**Configuration:** Created dynamically in workflow

**Model:** `anthropic/claude-sonnet-4` (configurable)

**Provider:** OpenRouter (configurable)

**Process:**
1. Receive issue content
2. Analyze using AI model
3. Return structured JSON response
4. Include helpful commentary

### 5. Label System

**Categories:**
- 🐛 `bug` - Technical issues
- ✨ `feature` - Feature requests
- ❓ `question` - Questions
- 🚨 `urgent` - Urgent items
- 🎉 `festival-feedback` - Festival specific

**Priorities:**
- 🔴 `priority: high`
- 🟡 `priority: medium`
- 🟢 `priority: low`

**Status:**
- 🔍 `needs-triage`
- 👀 `needs-review`
- 🚧 `in-progress`
- ✅ `resolved`

**Areas:**
- 🏟️ `venue`
- 🍔 `food-beverages`
- 🎵 `entertainment`
- ♿ `accessibility`
- 👥 `staff`

## Data Flow

1. **User Action** → Creates issue using template
2. **GitHub Webhook** → Triggers workflow
3. **Workflow Setup** → Prepares environment
4. **Script Execution** → Runs triage logic
5. **Goose Analysis** → AI analyzes content
6. **Result Processing** → Parses JSON response
7. **GitHub API** → Applies labels and comments
8. **Notification** → User sees updated issue

## Security Considerations

### Secrets Management
- API keys stored as GitHub Secrets
- Never exposed in logs or code
- Accessed only by authorized workflows

### Permissions
- Workflows run with minimal required permissions
- `issues: write` - To add labels and comments
- `contents: read` - To access repository files

### API Rate Limits
- GitHub API: 5,000 requests/hour for authenticated
- OpenRouter: Depends on plan
- Workflows include error handling

## Scalability

### Current Limits
- GitHub Actions: 2,000 minutes/month (free tier)
- Workflow runs: Concurrent based on plan
- Issue processing: ~2-3 minutes per issue

### Optimization Opportunities
1. Batch processing for multiple issues
2. Caching Goose configuration
3. Parallel workflow execution
4. Rate limit handling

## Error Handling

### Workflow Level
- Retries on transient failures
- Error logging in Actions tab
- Fallback to default labels

### Script Level
- JSON parsing validation
- Default values if analysis fails
- API error handling
- Timeout protection

## Monitoring

### GitHub Actions
- View workflow runs in Actions tab
- Check individual step logs
- Monitor success/failure rates

### Issue Activity
- Track triage completion
- Review label distribution
- Monitor response times

## Extension Points

### Custom Analysis
- Modify prompt in `triage.sh`
- Add custom classification rules
- Include additional context

### Integration
- Add Slack notifications
- Connect to project management tools
- Sync with external databases

### Automation
- Auto-assign to team members
- Create follow-up tasks
- Update project boards

## Technology Stack

- **Platform:** GitHub
- **CI/CD:** GitHub Actions
- **AI Engine:** Goose CLI
- **LLM Provider:** OpenRouter (Claude/GPT)
- **Scripting:** Bash
- **API:** GitHub REST API v3
- **Format:** YAML, Markdown, JSON

## Performance Metrics

### Typical Workflow Execution
- Setup: ~30 seconds
- Goose analysis: ~60-90 seconds
- API operations: ~10-20 seconds
- **Total: ~2-3 minutes**

### Resource Usage
- Compute: Minimal (bash scripts)
- Memory: Low (text processing)
- Storage: Negligible (logs only)
- API calls: 2 per issue (comment + labels)

## Future Enhancements

1. **Machine Learning**
   - Train custom models on historical data
   - Improve categorization accuracy
   - Sentiment analysis

2. **Advanced Features**
   - Multi-language support
   - Image analysis for screenshots
   - Duplicate detection

3. **Integrations**
   - Jira, Linear, Asana sync
   - Slack, Discord notifications
   - Analytics dashboards

4. **Automation**
   - Auto-close duplicates
   - Schedule follow-ups
   - Generate reports

---

**Last Updated:** December 8, 2024
