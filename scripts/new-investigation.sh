#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

if [ -z "$1" ]; then
    echo "Usage: $0 <slug>"
    echo "Example: $0 my-new-investigation"
    exit 1
fi

SLUG="$1"

# Get current year-month for the pages directory
YEAR_MONTH=$(date +%Y-%m)

# Target directories
PAGE_DIR="$ROOT_DIR/pages/$YEAR_MONTH/$SLUG"
SQL_DIR="$ROOT_DIR/sources/xatu_cbt"

# Check if page already exists
if [ -d "$PAGE_DIR" ]; then
    echo "Error: Page already exists at $PAGE_DIR"
    exit 1
fi

# Create page directory
mkdir -p "$PAGE_DIR"

# Copy template
cp "$ROOT_DIR/templates/investigation.md" "$PAGE_DIR/index.md"

# Create SQL file
SQL_SLUG=$(echo "$SLUG" | tr '-' '_')
cp "$ROOT_DIR/templates/example.sql" "$SQL_DIR/${SQL_SLUG}_example.sql"

echo "Created:"
echo "  - $PAGE_DIR/index.md"
echo "  - $SQL_DIR/${SQL_SLUG}_example.sql"
echo ""
echo "Next steps:"
echo "  1. Update the placeholders in $PAGE_DIR/index.md"
echo "  2. Update the SQL query in $SQL_DIR/${SQL_SLUG}_example.sql"
