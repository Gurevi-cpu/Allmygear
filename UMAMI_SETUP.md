# 🚀 Быстрая установка Umami Analytics (бесплатно)

## Шаг 1: Deploy на Vercel (1 клик)

Нажмите эту кнопку для автоматического деплоя:

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/umami-software/umami&project-name=allmygear-analytics&repository-name=allmygear-analytics&demo-title=Umami%20Analytics&demo-description=Privacy-friendly%20web%20analytics&demo-url=https://umami.is&demo-image=https://umami.is/images/social-card.png)

**Или перейдите по ссылке:**
👉 https://vercel.com/new/clone?repository-url=https://github.com/umami-software/umami

---

## Шаг 2: Настройка базы данных

### Вариант А: Использовать текущий Supabase (рекомендуется)

Во время установки Vercel попросит переменные окружения. Добавьте:

```
DATABASE_URL=postgresql://postgres.ezsurtlznvwsncszfckj:[YOUR-PASSWORD]@aws-0-eu-central-1.pooler.supabase.com:6543/postgres
```

**Где взять пароль:**
1. Откройте Supabase Dashboard → https://supabase.com/dashboard/project/ezsurtlznvwsncszfckj/settings/database
2. Скопируйте пароль (или создайте новый)
3. Замените `[YOUR-PASSWORD]` в DATABASE_URL

### Вариант Б: Создать новую БД в Vercel Postgres (проще)

1. При деплое выберите "Add Vercel Postgres"
2. Vercel автоматически создаст базу и настроит всё
3. Бесплатный лимит: 256 MB хранилища (достаточно для старта)

---

## Шаг 3: Первый вход

После успешного деплоя:

1. Откройте ваш Umami URL (например: `allmygear-analytics.vercel.app`)
2. Войдите с дефолтными данными:
   - **Username:** `admin`
   - **Password:** `umami`
3. **Сразу смените пароль!** (Settings → Profile → Change Password)

---

## Шаг 4: Добавьте сайт

1. В Umami dashboard: **Settings → Websites → Add website**
2. Заполните:
   - **Name:** AllMyGear
   - **Domain:** `all-my-gear.pro`
3. Нажмите **Save**
4. Скопируйте **Website ID** (например: `a1b2c3d4-e5f6-g7h8-i9j0-k1l2m3n4o5p6`)

---

## Шаг 5: Получите tracking code

В Umami:
1. Откройте ваш сайт (AllMyGear)
2. Нажмите **Settings** (шестерёнка)
3. Перейдите на вкладку **Tracking Code**
4. Скопируйте весь код (будет выглядеть так):

```html
<script defer src="https://allmygear-analytics.vercel.app/script.js" data-website-id="ваш-website-id"></script>
```

---

## Шаг 6: Дайте мне tracking code

Отправьте мне скопированный код, и я добавлю его на сайт!

---

## ✅ Что получите:

- 📊 Просмотры страниц
- 👥 Уникальные посетители
- 🌍 География
- 📱 Устройства
- 🔗 Источники трафика
- ⏱️ Время на сайте
- 📈 Realtime dashboard

Всё **бесплатно** и **privacy-friendly**! 🔒

---

## 🆘 Если возникли проблемы:

1. **Ошибка базы данных:** Проверьте DATABASE_URL в Vercel → Settings → Environment Variables
2. **Не запускается:** Посмотрите логи в Vercel → Deployments → [ваш деплой] → View Function Logs
3. **Забыли пароль:** Подключитесь к БД и сбросьте: https://umami.is/docs/reset-password
