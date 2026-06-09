#!/bin/bash
# 公開データを GitHub Pages に反映する
set -euo pipefail
cd "$(dirname "$0")"

if [[ ! -f published-data.json ]]; then
  echo "ERROR: published-data.json がありません"
  echo "ブラウザで「公開用に書き出す」を押して、このフォルダに置いてください"
  exit 1
fi

git add published-data.json index.html 2>/dev/null || true
git add published-data.json

if git diff --cached --quiet; then
  echo "変更なし（すでに最新）"
else
  git commit -m "公開データを更新 ($(date '+%Y-%m-%d %H:%M'))"
  git push
  echo "PUSH OK"
fi

echo ""
echo "公開URL: https://opt-in-1.github.io/mainichi-chinese-flow/"
