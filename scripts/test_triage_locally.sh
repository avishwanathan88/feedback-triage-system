#!/bin/bash

# Local test script to verify Goose triage logic
# This tests the analysis without needing to push to GitHub

set -e

echo "🧪 Testing Goose Triage Logic Locally"
echo "========================================"
echo ""

# Check if goose is installed
if ! command -v goose &> /dev/null; then
    echo "❌ Error: Goose CLI is not installed"
    echo "Install from: https://github.com/block/goose"
    exit 1
fi

echo "✅ Goose CLI found: $(which goose)"
echo ""

# Test issues
declare -a test_issues=(
    "URGENT: Sound system completely failed during main stage performance at 8:30 PM. This lasted for about 15 minutes and caused significant frustration among the crowd of approximately 500 attendees."
    "More vegetarian and vegan food options needed. Overall had a great time at the festival! However, I noticed there were limited options for vegetarians and vegans."
    "Excellent accessibility accommodations and parking! The wheelchair-accessible pathways throughout the venue were wide and well-maintained. Thank you for making this such a positive experience!"
)

declare -a expected_categories=(
    "urgent/bug"
    "feature"
    "positive/feedback"
)

echo "Running triage analysis on 3 test issues..."
echo ""

for i in "${!test_issues[@]}"; do
    issue_num=$((i + 1))
    issue_text="${test_issues[$i]}"
    expected="${expected_categories[$i]}"
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "📋 TEST ISSUE $issue_num"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Issue: ${issue_text:0:100}..."
    echo "Expected category: $expected"
    echo ""
    
    # Create prompt for goose
    prompt="Analyze this GitHub issue and provide triage information:

$issue_text

Please analyze this feedback and provide:
1. Category (bug/feature/question/urgent/documentation)
2. Priority (high/medium/low)
3. A helpful, friendly comment with emoji
4. Suggested labels as a comma-separated list

Format your response as JSON:
{
  \"category\": \"...\",
  \"priority\": \"...\",
  \"comment\": \"...\",
  \"labels\": [\"label1\", \"label2\", \"label3\"]
}"

    echo "🤖 Running Goose analysis..."
    
    # Run goose and capture output
    result=$(echo "$prompt" | goose session start --profile default 2>&1 || echo "Error running goose")
    
    echo ""
    echo "📊 Goose Response:"
    echo "─────────────────────────────────────────────────"
    echo "$result" | tail -n 20
    echo "─────────────────────────────────────────────────"
    echo ""
    
    # Try to extract JSON
    json=$(echo "$result" | grep -A 20 '{' | grep -B 20 '}' | sed -n '/^{/,/^}/p' | head -1 || echo "")
    
    if [ -n "$json" ]; then
        echo "✅ Successfully extracted triage data"
        echo "$json" | python3 -m json.tool 2>/dev/null || echo "$json"
    else
        echo "⚠️  Could not extract JSON from response"
    fi
    
    echo ""
    read -p "Press Enter to continue to next test..."
    echo ""
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 Local testing complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Next steps:"
echo "1. Review the triage results above"
echo "2. Adjust the prompt in scripts/triage.sh if needed"
echo "3. Push to GitHub and test with real issues"
echo ""
