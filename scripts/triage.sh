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
GOOSE_OUTPUT=$(goose run --text "$(cat /tmp/issue_analysis_prompt.txt)" --no-session --quiet 2>&1 | tail -n 100)

echo "Goose analysis output:"
echo "$GOOSE_OUTPUT"

# Extract JSON from goose output (handle markdown code blocks)
# First try to extract from markdown code blocks
TRIAGE_JSON=$(echo "$GOOSE_OUTPUT" | sed -n '/```json/,/```/p' | sed '1d;$d' | head -1)

# If that didn't work, try to find raw JSON
if [ -z "$TRIAGE_JSON" ]; then
    TRIAGE_JSON=$(echo "$GOOSE_OUTPUT" | grep -A 100 '{' | grep -B 100 '}' | sed -n '/^{/,/^}/p' | head -1)
fi

if [ -z "$TRIAGE_JSON" ]; then
    echo "⚠️  Could not extract JSON from goose output, using defaults"
    TRIAGE_JSON='{"category":"feedback","priority":"medium","comment":"✨ Thank you for your feedback! We will review this shortly.","labels":["feedback","needs-review"]}'
fi

echo "Extracted triage data:"
echo "$TRIAGE_JSON"

# Parse the JSON response using Python (available in GitHub Actions)
PARSED=$(python3 -c "
import json
import sys
try:
    data = json.loads('''$TRIAGE_JSON''')
    print(data.get('category', 'feedback'))
    print(data.get('priority', 'medium'))
    # Escape the comment for bash
    comment = data.get('comment', '✨ Thank you for your feedback! We will review this shortly.')
    print(comment.replace('\"', '\\\"').replace('\n', ' '))
    print(','.join(data.get('labels', ['feedback', 'needs-review'])))
except:
    print('feedback')
    print('medium')
    print('✨ Thank you for your feedback! We will review this shortly.')
    print('feedback,needs-review')
" 2>/dev/null)

# Split the parsed output
CATEGORY=$(echo "$PARSED" | sed -n '1p')
PRIORITY=$(echo "$PARSED" | sed -n '2p')
COMMENT=$(echo "$PARSED" | sed -n '3p')
LABELS=$(echo "$PARSED" | sed -n '4p')

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
