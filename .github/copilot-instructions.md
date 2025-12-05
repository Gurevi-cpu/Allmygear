# ALLMYGEAR Copilot Instructions

## Project Overview
ALLMYGEAR is a single-page vanilla JavaScript gear list manager for outdoor trips. No build system, no frameworks—just HTML, CSS, and JavaScript with `localStorage` persistence.

## Architecture & Data Flow
- **Single IIFE module** (`app.js`): All logic wrapped in one immediately-invoked function expression with no global pollution
- **localStorage persistence**: Single key `'allmygear.items'` stores JSON array of gear items
- **State management**: In-memory `items` array syncs to localStorage on every mutation
- **Rendering strategy**: Full innerHTML replacement on every update—no virtual DOM or incremental updates
- **Event delegation**: Single listener on `#cards` container handles all card interactions (edit, delete, toggle)

## Key Patterns & Conventions

### Data Model
Each item has: `id`, `category`, `name`, `brand`, `model`, `weight` (grams), `price` (RUB), `year`, `image` (base64 dataURL), `created` (timestamp)
```javascript
{id: 'abc123', category: 'Shelter', name: 'Tent', brand: 'MSR', model: 'Hubba', weight: 1200, price: 45000, year: 2023, image: 'data:image/jpeg;base64,...', created: 1701234567890}
```

### Autocomplete System
- **Brand autocomplete**: 300+ outdoor brands including premium (Arc'teryx, Patagonia), budget (Decathlon, Naturehike), ultralight cottage brands (Zpacks, Hyperlite), Russian brands (Bask, Splav), and specialized categories (climbing, footwear, electronics)
- **Model autocomplete**: Dynamic datalist populated from existing items matching selected brand
- **Modal form**: Uses `#brand-list` and `#model-list` datalists
- **Inline edit**: Uses unique datalists per item (`inline-brand-list-{id}`, `inline-model-list-{id}`)
- **Implementation**: `setupAutocomplete()` for modal, `createInlineDataLists()` + `setupInlineAutocomplete()` for cards
- Brand database stored in `outdoorBrands` array constant with comprehensive categorization (alpine, climbing, footwear, backpacks, tents, sleeping bags, cooking, hydration, electronics, clothing, hunting, budget, ultralight, paddle sports, winter sports, trail running)

### Image Processing
- **Target size**: 200KB per image stored as base64 in localStorage
- **Compression flow**: Scale to max 1024px width → iteratively reduce JPEG quality (0.9 → 0.4) → if still too large, shrink dimensions by 20% and retry
- See `processImageFile()` for the recursive quality/dimension reduction algorithm

### Category System
- **Fixed categories**: Shelter, Bed, Furniture, Clothing, Bag / Package, Kitchen, Electronic, Personal items, Tools, Equipment
- Categories are hardcoded in HTML `<select>` options and in `render()` function's `allCategories` array—must sync both locations
- Collapsible category groups: State managed via `.collapsed` class toggle on `.category-items`

### Inline Card Editing
- Each card can expand inline with editable fields (not just the top form)
- Edit mode triggered by `.btn.icon.edit` → shows `.card-edit-form` → saves directly to `items` array
- Uses data attributes `data-field="name"` to map inputs to item properties
- Category field is readonly in inline edit (prevents moving items between categories mid-edit)

## Styling Patterns
- **CSS custom properties**: All colors, fonts defined in `:root` (e.g., `--font-heading`, `--accent`, `--glass`)
- **Gradient backgrounds**: Dark gradient on `body`, light glass-morphism on panels
- **Font stack**: Rubik for headings, Inter for body (Google Fonts preconnect)
- **Responsive breakpoint**: 900px switches from 2-column grid (`360px 1fr`) to single column

## Developer Workflows

### Running Locally
```bash
open index.html  # macOS
# Or just double-click index.html
```
No server needed—100% static files.

### Debugging Data
Export from browser console:
```javascript
localStorage.getItem('allmygear.items')
```
Import (overwrite):
```javascript
localStorage.setItem('allmygear.items', '[ JSON here ]')
```

### Testing Image Compression
Upload images > 200KB and check console for compression logs. Preview appears in form, base64 stored on submit.

## Critical Implementation Details

### Why IIFE?
Prevents global scope pollution—all variables (`items`, `editingId`, functions) scoped to module.

### Why Full Re-render?
Simple mental model, no state diffing needed. Performance adequate for <1000 items.

### Currency & Units
- Weight: grams (g), auto-converts to kg display if ≥1000g
- Price: Russian Rubles (₽), formatted with `toLocaleString('en-US')` for thousand separators

## Common Modification Patterns

### Adding a New Category
1. Add option to both `<select>` elements in `index.html` (form + filter)
2. Add to `allCategories` array in `app.js` `render()` function

### Adding a New Item Field
1. Add input to form in `index.html`
2. Capture value in form submit handler's `data` object
3. Add to inline edit form template in `render()` card HTML
4. Update inline save handler to capture new field

### Changing Image Size Limit
Modify `MAX_IMAGE_SIZE` constant (default 200KB = `200 * 1024` bytes) and `MAX_WIDTH` for resizing (default 1024px).

## External Dependencies
- Google Fonts: Inter (body) & Rubik (headings) via preconnect
- `AMG_icon.svg`: Logo file referenced in header (must exist in root)

## Future Enhancement Notes (from README)
Potential features not yet implemented: JSON import/export UI, printable view, cloud sync, external image storage.
