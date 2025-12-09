#!/bin/bash

# Script to create all necessary labels for the feedback triage system
# Usage: ./scripts/create_labels.sh YOUR_USERNAME/feedback-triage-system

if [ -z "$1" ]; then
    echo "Usage: $0 OWNER/REPO"
    echo "Example: $0 johndoe/feedback-triage-system"
    exit 1
fi

REPO=$1

echo "Creating labels for repository: $REPO"
echo "This requires GitHub CLI (gh) to be installed and authenticated"
echo ""

# Check if gh is installed
if ! command -v gh &> /dev/null; then
    echo "Error: GitHub CLI (gh) is not installed"
    echo "Install it from: https://cli.github.com/"
    exit 1
fi

# Category Labels
echo "Creating category labels..."
gh label create "bug" --color "d73a4a" --description "🐛 Something isn't working" --repo $REPO --force
gh label create "feature" --color "a2eeef" --description "✨ New feature or request" --repo $REPO --force
gh label create "question" --color "d876e3" --description "❓ Further information requested" --repo $REPO --force
gh label create "urgent" --color "b60205" --description "🚨 Requires immediate attention" --repo $REPO --force
gh label create "documentation" --color "0075ca" --description "📚 Documentation improvements" --repo $REPO --force
gh label create "festival-feedback" --color "fbca04" --description "🎉 Festival-specific feedback" --repo $REPO --force
gh label create "positive" --color "7FD87A" --description "✅ Positive feedback" --repo $REPO --force

# Priority Labels
echo "Creating priority labels..."
gh label create "priority: high" --color "d73a4a" --description "🔴 High priority" --repo $REPO --force
gh label create "priority: medium" --color "fbca04" --description "🟡 Medium priority" --repo $REPO --force
gh label create "priority: low" --color "0e8a16" --description "🟢 Low priority" --repo $REPO --force

# Status Labels
echo "Creating status labels..."
gh label create "needs-triage" --color "d4c5f9" --description "🔍 Waiting for triage" --repo $REPO --force
gh label create "needs-review" --color "5EBEFF" --description "👀 Needs team review" --repo $REPO --force
gh label create "in-progress" --color "FFA500" --description "🚧 Currently being worked on" --repo $REPO --force
gh label create "resolved" --color "0e8a16" --description "✅ Issue resolved" --repo $REPO --force

# Area Labels
echo "Creating area labels..."
gh label create "venue" --color "1d76db" --description "🏟️ Venue related" --repo $REPO --force
gh label create "food-beverages" --color "f9d0c4" --description "🍔 Food and beverages" --repo $REPO --force
gh label create "entertainment" --color "8250df" --description "🎵 Entertainment related" --repo $REPO --force
gh label create "accessibility" --color "39d5c5" --description "♿ Accessibility related" --repo $REPO --force
gh label create "staff" --color "ff69b4" --description "👥 Staff related" --repo $REPO --force

echo ""
echo "✅ All labels created successfully!"
echo "View them at: https://github.com/$REPO/labels"
