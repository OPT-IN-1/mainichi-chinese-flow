#!/bin/bash
# 公開データを GitHub Pages に反映する
set -euo pipefail
cd "$(dirname "$0")"

if [[ ! -f published-data.json ]]; then
  echo "ERROR: published-data.json がありません"
  echo "ブラウザで「公開用に書き出す」を押して、このフォルダに置いてください"
  exit 1
fi

# ローカル file:// でも編集データを読めるよう JS に変換
NODE="/Applications/Cursor.app/Contents/Resources/app/resources/helpers/node"
if [[ -x "$NODE" ]]; then
  "$NODE" -e "const fs=require('fs');const d=fs.readFileSync('published-data.json','utf8');fs.writeFileSync('published-data.js','window.PUBLISHED_DATA='+d+';\n');"
fi

git add published-data.json published-data.js index.html 2>/dev/null || true
git add published-data.json published-data.js

if git diff --cached --quiet; then
  echo "変更なし（すでに最新）"
else
  git commit -m "公開データを更新 ($(date '+%Y-%m-%d %H:%M'))"
  git push
  echo "PUSH OK"
fi

echo ""
echo "公開URL: https://opt-in-1.github.io/mainichi-chinese-flow/"
