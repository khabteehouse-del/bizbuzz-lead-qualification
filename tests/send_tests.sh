#!/bin/bash
# usage: WEBHOOK_URL=https://YOUR-N8N/webhook-test/bizbuzz-lead SECRET=yourSecret ./send_tests.sh
python3 - <<'PY' | while read -r l; do curl -s -X POST "$WEBHOOK_URL" -H "Content-Type: application/json" -H "X-Webhook-Secret: $SECRET" -d "$l"; echo; done
import json;[print(json.dumps(x)) for x in json.load(open("test_leads.json"))]
PY
