#!/usr/bin/env bash
# Создаёт публичный репо honeymoon-support на GitHub, пушит main и включает GitHub Pages.
# Один раз:  gh auth login
set -euo pipefail

REPO_NAME="honeymoon-support"
cd "$(dirname "$0")"

if ! command -v gh &>/dev/null; then
  echo "Нужен GitHub CLI. Установка:  brew install gh" >&2
  exit 1
fi

if ! gh auth status &>/dev/null; then
  echo "Сначала войдите в GitHub:  gh auth login" >&2
  exit 1
fi

OWNER="$(gh api user -q .login)"
FULL="${OWNER}/${REPO_NAME}"
echo "Аккаунт GitHub: ${OWNER} → репозиторий ${FULL}"

# 1) Репо уже на GitHub — привязываем origin и пушим
# 2) Нет — создаём, origin и push делает gh
if gh repo view "${FULL}" &>/dev/null; then
  echo "Репозиторий ${FULL} уже существует — push в origin."
  if ! git remote get-url origin &>/dev/null; then
    git remote add origin "https://github.com/${FULL}.git"
  fi
  git push -u origin main
else
  echo "Создаю публичный ${FULL} и делаю первый push..."
  gh repo create "${FULL}" --public --source=. --remote=origin \
    --description="Honeymoon: страница службы поддержки" --push
fi

sleep 2

# GitHub Pages: ветка main, публикация из корня
echo "Включаю GitHub Pages (main, /)..."
if gh api "repos/${FULL}/pages" 2>/dev/null | grep -q '"html_url"'; then
  echo "GitHub Pages уже настроен."
else
  gh api "repos/${FULL}/pages" -X POST --input - <<'JSON'
{
  "build_type": "legacy",
  "source": {
    "branch": "main",
    "path": "/"
  }
}
JSON
  echo "Запрошена публикация GitHub Pages."
fi

# Canonical = фактический URL Pages
CANON="https://${OWNER}.github.io/${REPO_NAME}/"
if ! grep -qF "rel=\"canonical\" href=\"${CANON}\"" index.html; then
  sed -i '' "s|<link rel=\"canonical\" href=\"[^\"]*\" />|<link rel=\"canonical\" href=\"${CANON}\" />|" index.html
  if ! git diff --quiet index.html; then
    git add index.html
    git commit -m "chore: set canonical to published GitHub Pages URL"
    git push origin main
  fi
fi

echo ""
echo "Готово. Через 1–2 минуты: ${CANON}"
echo "Статус: gh api repos/${FULL}/pages -q .html_url 2>/dev/null || true"
