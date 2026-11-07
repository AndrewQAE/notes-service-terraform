#!/usr/bin/env bash
# Step 6: test the API end-to-end. Run from the project folder after `terraform apply`.
set -euo pipefail

API=$(terraform output -raw api_endpoint)
echo "Endpoint: $API"
echo

echo "== POST (add a note) =="
RESP=$(curl -s -X POST "$API" -H "Content-Type: application/json" -d '{"content": "My first note"}')
echo "$RESP"
NOTE_ID=$(echo "$RESP" | python3 -c 'import sys,json; print(json.load(sys.stdin)["noteId"])')
echo

echo "== GET (list notes) =="
curl -s "$API"; echo; echo

echo "== PUT (update note $NOTE_ID) =="
curl -s -X PUT "$API" -H "Content-Type: application/json" \
  -d "{\"noteId\": \"$NOTE_ID\", \"content\": \"Updated note content\"}"; echo; echo

echo "== GET (after update) =="
curl -s "$API"; echo; echo

echo "== DELETE (note $NOTE_ID) =="
curl -s -X DELETE "$API" -H "Content-Type: application/json" \
  -d "{\"noteId\": \"$NOTE_ID\"}"; echo; echo

echo "== GET (after delete) =="
curl -s "$API"; echo
