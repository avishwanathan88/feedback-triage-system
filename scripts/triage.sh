#!/bin/bash
set -e

echo "🚀 Starting feedback triage for issue #${ISSUE_NUMBER}"

# Create a goose profile for GitHub Actions
mkdir -p ~/.config/goose

cat > ~/.config/goose/config.yaml <<EOF
GOOSE_PROVIDER: openrouter
GOOSE_MODEL: anthropic/claude-sonnet-4
extensions:
  developer:
    enabled: true
    type: builtin
    name: developer
EOF

# Set the OpenRouter API key
export OPENROUTER_API_KEY="${OPENROUTER_API_KEY}"

# Create a prompt for goose to analyze the issue
cat > /tmp/issue_analysis_prompt.txt <<EOF
Analyze this GitHub issue and provide triage information:

Issue #${ISSUE_NUMBER}: ${ISSUE_TITLE}

${ISSUE_BODY}

Please analyze this feedback and provide:
1. Category (bug/feature/question/urgent/documentation)
2. Priority (high/medium/low)
3. A helpful, friendly comment with emoji
4. Suggested labels as a comma-separated list

Format your response as JSON:
{
  "category": "...",
  "priority": "...",
  "comment": "...",
  "labels": ["label1", "label2", "label3"]
}
EOF

# Run goose to analyze the issue
echo "🔍 Analyzing issue with Goose AI..."
GOOSE_OUTPUT=$(goose run "$(cat /tmp/issue_analysis_prompt.txt)" --profile default 2>&1 | tail -n 50)

echo "Goose analysis output:"
echo "$GOOSE_OUTPUT"

# Extract JSON from goose output (it might be wrapped in markdown)
TRIAGE_JSON=$(echo "$GOOSE_OUTPUT" | grep -A 100 '{' | grep -B 100 '}' | sed -n '/^{/,/^}/p' | head -1)

if [ -z "$TRIAGE_JSON" ]; then
    echo "⚠️  Could not extract JSON from goose output, using defaults"
    TRIAGE_JSON='{"category":"feedback","priority":"medium","comment":"✨ Thank you for your feedback! We will review this shortly.","labels":["feedback","needs-review"]}'
fi

echo "Extracted triage data:"
echo "$TRIAGE_JSON"

# Parse the JSON response
CATEGORY=$(echo "$TRIAGE_JSON" | grep -o '"category":"[^"]*"' | cut -d'"' -f4)
PRIORITY=$(echo "$TRIAGE_JSON" | grep -o '"priority":"[^"]*"' | cut -d'"' -f4)
COMMENT=$(echo "$TRIAGE_JSON" | grep -o '"comment":"[^"]*"' | sed 's/"comment":"//;s/"$//')
LABELS=$(echo "$TRIAGE_JSON" | grep -o '"labels":\[[^]]*\]' | sed 's/"labels":\[//;s/\]//;s/"//g')

# Default values if parsing fails
CATEGORY=${CATEGORY:-feedback}
PRIORITY=${PRIORITY:-medium}
COMMENT=${COMMENT:-✨ Thank you for your feedback! We will review this shortly.}
LABELS=${LABELS:-feedback,needs-review}

echo "📊 Triage Results:"
echo "  Category: $CATEGORY"
echo "  Priority: $PRIORITY"
echo "  Labels: $LABELS"

# Add comment to issue
echo "💬 Adding comment to issue..."
curl -X POST \
  -H "Authorization: token ${GITHUB_TOKEN}" \
  -H "Accept: application/vnd.github.v3+json" \
  "https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/issues/${ISSUE_NUMBER}/comments" \
  -d "{\"body\":\"${COMMENT}\"}"

# Add labels to issue
echo "🏷️  Adding labels to issue..."
IFS=',' read -ra LABEL_ARRAY <<< "$LABELS"
LABELS_JSON="["
for label in "${LABEL_ARRAY[@]}"; do
    label=$(echo "$label" | xargs) # trim whitespace
    LABELS_JSON="${LABELS_JSON}\"${label}\","
done
LABELS_JSON="${LABELS_JSON%,}]"

curl -X POST \
  -H "Authorization: token ${GITHUB_TOKEN}" \
  -H "Accept: application/vnd.github.v3+json" \
  "https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/issues/${ISSUE_NUMBER}/labels" \
  -d "{\"labels\":${LABELS_JSON}}"

echo "✅ Triage complete!"
