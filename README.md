
# ALLMYGEAR — Personal Gear List

This is a simple static page to create and manage a gear list for trips.

Features:
- Add items with fields: category, name, brand, model, weight (g), price (₽).
- Edit and delete items.
- Search by name and filter by category.
- Save data to the browser's `localStorage`.
- Upload a small photo; images are automatically resized/compressed to keep storage reasonable.

How to run
1. Open `index.html` in your browser (double-click or use `open index.html` on macOS).

Notes
- Data is stored locally in your browser — clearing browser storage will remove the list.
- To export the raw JSON from the console: `localStorage.getItem('allmygear.items')`.

Files
- `index.html` — main page
- `styles.css` — styles
- `app.js` — application logic

If you want, I can add JSON import/export, a printable view, cloud sync, or switch to storing images externally.
