#!/bin/bash
set -e

CONFIG_FILE=config/spec-meta.json

# Optional: Allow empty args to keep current value
SPEC_ID="$1"
COLLECTION_ID="$2"

echo "🔄 Updating spec-meta.json..."

TMP_FILE="${CONFIG_FILE}.tmp"

jq --arg sid "$SPEC_ID" \
   --arg cid "$COLLECTION_ID" \
   --arg now "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
   '
   if $sid != "" then .POSTMAN_SPEC_ID = $sid else . end |
   if $cid != "" then .POSTMAN_COLLECTION_ID = $cid else . end |
   .LAST_UPDATED = $now
   ' "$CONFIG_FILE" > "$TMP_FILE"

mv "$TMP_FILE" "$CONFIG_FILE"

echo "✅ Updated $CONFIG_FILE"
