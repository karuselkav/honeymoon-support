# Honeymoon — страница поддержки

Публичный **статичный** сайт (один `index.html`) для [GitHub Pages](https://pages.github.com/).

## Публикация

1. Создайте **новый** репозиторий на GitHub, например `honeymoon-support`, видимость **Public**.
2. **Не** добавляйте README/gitignore в мастер при создании (или выложите сразу с этим пакетом).
3. Содержимое папки `honeymoon-support` (этот снимок) положите в **корень** репо и зафиксируйте:

   `index.html` и `.nojekyll`

4. **Settings → Pages** → **Deploy from a branch** → `main` → папка **`/ (root)`** → Save.
5. Сайт: `https://<ваш-логин>.github.io/honeymoon-support/`

Правки текста, почты, FAQ: только в `index.html`, блок `CONFIG` внизу.

Если смените имя репозитория, обновите `link rel="canonical"` в `<head>`.

Эта папка в проекте `Ephemera` существует как **отдельный** клон-репозиторий: при желании вынесите `honeymoon-support` в отдельную директорию и инициализируйте там `git` заново, не смешивая с приватным кодом приложения.
