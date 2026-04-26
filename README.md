# Honeymoon — страница поддержки (GitHub Pages)

Статичный сайт: `index.html` (поддержка), `privacy.html` (политика конфиденциальности для App Store / Apple). Репозиторий — **публичный**, отдельно от кода приложения.

**App Store (политика конфиденциальности):**  
<https://karuselkav.github.io/honeymoon-support/privacy.html>

## Всё настроить одной командой (после входа в GitHub)

1. **Один раз** войдите в CLI (в браузере откроется GitHub):

   ```bash
   gh auth login
   ```

2. В этой папке выполните:

   ```bash
   ./publish.sh
   ```

Скрипт: создаёт `https://github.com/ВАШ_ЛОГИН/honeymoon-support` (если ещё нет), пушит `main`, включает **GitHub Pages** из **корня** ветки `main`, при необходимости правит `canonical` в `index.html`.

Сайт: `https://ВАШ_ЛОГИН.github.io/honeymoon-support/`

**Зависимость:** [GitHub CLI](https://cli.github.com/) (`brew install gh` — уже сделан на вашей машине, если `gh` в PATH).

## Вручную (если не хотите скрипт)

1. New repository → имя `honeymoon-support` → **Public** → без README.
2. `git remote add origin …` и `git push -u origin main`
3. **Settings → Pages** → Branch `main`, folder **/ (root)**.

## Правки контента

- `index.html` — блок `CONFIG` (почта, Telegram, FAQ).
- `privacy.html` — политика; контент в встроенном `I[lang].blocks` (при смене практик обновите текст и дату `LASTUPD` в скрипте).
