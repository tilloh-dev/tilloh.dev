# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- [global] Adopt tide process 0.4.4: `AGENTS.md` replaces `CLAUDE.md`, docs for requirements, backlog and operations, Renovate config, `.claude/settings.json` for the tide plugin.
- [global] CI workflow `ci.yml` with lint, type check, test, build, audit, filesystem and backend image scan, changelog check and a single required `gate` job.
- [home] Replace Navigation grid on homepage with a time-based greeting component that addresses the current user by their identifier (morning/afternoon/evening/night, DE + EN).

### Changed

- [global] Switch package manager from npm to a pnpm workspace (frontend, backend, e2e); resolved versions stay as before.
- [global] Deploy and restart jobs use the GitHub environment `production`; third-party actions are pinned by commit SHA.
- [backend] Declare dependencies that were only resolved via npm hoisting: `express`, `@fastify/cors`, `mongodb`, `@types/express`.
- [global] Replace broken date/ID emojis with Carbon `EventSchedule` and `Identification` icons across admin and feature components (Identifiers, Toggles, LinkPresets, Activities, Jokes, JokeOfTheDay).
- [global] Redesign login screen: add logo, `tilloh.dev` title, and tagline above the login input; left-align branding with the input field; compensate PNG transparent padding via negative margin.
- [global] Hide header and redirect to home route when no valid identifier is set; login input is shown full-screen without navigation elements.
- [global] Replace emoji storage-state indicator (🌐/📴) in header with colored Carbon Cloud/CloudOffline icons displayed inline after the page title.
- [global] Increase header route icon size to `1em` (relative to h2 font-size) and align it using flexbox with `gap: 0.3em`.

### Fixed

- [backend] Fix vulnerable dependencies: `fastify` 5.12.5 (authentication bypass), `@fastify/static` 10.1, `@fastify/busboy` 3.2 via overrides; npm removed from the backend runtime image.

### Removed

- [global] `develop` deployments to Docker Hub and the `.claude` submodule.

### Fixed

- [global] Fix GlobalMenu showing apps with inactive toggles: `getToggleValue` was defaulting to `true` when a toggle key was missing or unreachable, causing all apps to appear. Changed default to `false` so apps are only shown when their toggle is explicitly enabled.
- [global] Fix letter-spacing not applying to text elements: Carbon CSS explicitly sets `letter-spacing` via its own tokens on `p`, `h1`, etc., overriding the inherited `body` value. Added `body * { letter-spacing: var(--letter-spacing) !important }` to enforce the global spacing across all child elements.

### Changed

- [todo] Replace raw view-toggle buttons with Carbon Buttons (ghost/secondary/danger); add vertical divider between view toggles and cleanup button; replace raw mobile-edit button with Carbon ghost Button; edit button now always visible directly before delete button; add subtle dark row background with hover highlight; add `--default_padding` gap between edit and delete buttons; indent category headers by `--default_padding / 2`.
- [global] Translate all German source code comments to English across e2e specs, frontend components, and utility files.

### Added

- [e2e] Add E2E tests for Memorandum (5 tests: startup screen, search bar, FAB modal, create folder, load preset), Todo (5 tests: empty state, FAB, menu modal, create list, add todo) and Settings (5 tests: dashboard cards, theme switch, language switch, change language, persistence).
- [e2e] Introduce Playwright E2E test infrastructure: `/e2e/` package with Chromium tests against real backend (port 61155, separate DB `tilloh-dev-e2e`); 6 spec files (auth, navigation, about, uno-sort, jokes, admin); global setup/teardown for test data; auth bypass via localStorage injection; runs locally only (no CI).
- [backend] Decorate `GET /v1/health/readyz` with `@Public()` so Playwright's webServer health check responds without a Bearer token.
- [frontend] Self-hosted Londrina Solid font as global typeface via Fontsource; removed Carbon CDN duplicate; introduced CSS variables `--font-display` and `--font-mono`.
- [about] Code blocks now also use the Londrina Solid display font instead of the monospace font.
- [global] Introduce CSS variable `--letter-spacing: 0.05em` applied to `body` and all `bx--` elements for better readability with Londrina Solid.
- [frontend] Add `formatDate()` helper in `src/lib/util/format.ts` for robust date formatting (fallback for undefined/null/Invalid Date).

### Fixed

- [about] Replace HTML entities (`&lpar;`, `&lcub;`, `&gt;` etc.) in code blocks with actual characters — CodeSnippet renders plain text, entities were displayed literally.
- [jokes] Fix "Invalid Date": joke card is only shown when `joke.created` contains a valid date; correct locale tag from `'DE-de'` to BCP 47 `'de-DE'`.
- [memorandum] Fix folder column clipping in fixed grid: set `gap: var(--default_padding)` on `.content_area_fixed`, remove horizontal margins from `.link_box_fixed`.
- [hitstar] Mark step chips in menu as non-interactive (`pointer-events: none`, `cursor: default`); insert arrow separators (`→`) between chips.
- [uno-sort] Move UnoSort initialization from `onMount` to `$effect` so DOM refs are set only after `$initialized`, preventing `Cannot set properties of undefined` error.
- [docs] Add `docs/` folder with structured feature and shared infrastructure documentation for AI context (20 files: 1 template, 10 feature docs, 9 shared docs).
- [claude] Update commit-push skill to automatically detect and update affected docs before committing, with generic doc-to-source mapping that works across repositories.
- [hitstar] Show current game mode (Classic / Range) as small grey label top-left, only visible during an active game (hidden in the main menu).

### Changed

- [memorandum] Folder creation via FAB + modal instead of direct creation; FAB always visible; zero state also opens the modal.
- [jokes] Replace inline joke form with FAB + modal; page now shows only the random joke section.
- [hitstar] Remove Spotify embed (full iframe) from the reveal phase; only round tracker, abort button, flipped track card and next-round button are shown after guessing.
- [hitstar] Spotify track search now uses a single random year (1955–2025) per request instead of a fixed range to improve year distribution across decades.
- [hitstar] Add `genre:pop` filter to Spotify search query to increase the share of well-known tracks.

- [backend] Auto-seed toggles on application startup: missing toggles are created with default values from config; existing toggles are never overwritten.
- [hitstar] Add animated step-card tutorial in the menu that loops through 5 game steps with icons and auto-highlights each card every 2 seconds.
- [hitstar] Multi-mode architecture with Carbon Tabs (horizontal, compact, centered, no dropdown on any viewport) with spacing below for mode selection on the Hitstar start page.
- [hitstar] New "Range" game mode: set a 1–5 year range instead of guessing exactly; narrower ranges earn more points (max 50).
- [hitstar] Replace Spotify iframe embed in guessing phase with Spotify iFrame API: hidden iframe controlled by custom Play/Pause and Replay buttons for a clean, maskless player UI.

### Fixed

- [hitstar] Clicking a game mode tab no longer auto-starts a round; the menu always stays visible after page load or tab switch, and only "New Game" triggers the game.
- [hitstar] Album cover on the track card is now smaller on mobile viewports so all metadata (title, artist, album, year) fits within the card bounds without being clipped.
- [hitstar] Spotify iFrame API player no longer throws PlaybackError after the 30-second preview ends; clicking Play or Replay reloads the track via `loadUri` and starts playback automatically.
- [hitstar] Range mode NumberInput fields now correctly display the default value (2000) by overriding Carbon's oversized `padding-right` that was truncating the 4-digit year.
- [hitstar] CSS selector for Range submit button narrowed from `:global(button)` to `:global(button.bx--btn)` to prevent accidentally resizing the NumberInput stepper buttons.

### Changed

- [hitstar] Refactored Hitstar into shell + separate mode components (HitstarClassic, HitstarRange) with shared sub-components (HitstarRoundTracker, HitstarGameTopBar, HitstarLoadingScreen, HitstarResultsScreen).
- [hitstar] Refactored localStorage keys to mode-specific pattern (hitstar.classic.*, hitstar.range.*) with automatic migration of existing data.
- [hitstar] Hide best-score tile in menu when no score has been recorded yet.
- [hitstar] Replace static ProgressIndicator with custom icon step-cards (Headphones, Calendar, CheckmarkFilled, Repeat, Trophy) for the game tutorial.
- [hitstar] New "Hitstar" music year guessing game: listen to a 30-second preview and guess the release year across 10 rounds.
- [hitstar] Renamed backend NX library `spotify` to `hitstar`; endpoint changed from `GET /spotify/random-track` to `GET /hitstar/random-track`.
- [hitstar] Frontend route `/hitstar` with state machine (MENU → LOADING → GUESSING → REVEAL → RESULTS).
- [hitstar] Audio preview plays automatically in GUESSING state via iTunes preview URL.
- [hitstar] CSS 3D flip card animation on answer reveal, confetti for correct guesses, shake animation for wrong answers.
- [hitstar] Links to search on Spotify and open on Apple Music shown after reveal.
- [hitstar] Best score and active game state persisted in localStorage; interrupted games can be resumed.
- [hitstar] Abort button to cancel the current game at any time.

### Changed

- [hitstar] Reworked results screen with top/middle/bottom layout, colored per-round indicator squares (green/red), left border on result tiles, and removed score headline and Spotify/Apple Music links.
- [hitstar] Card border and year color now signal correct (green glow) or wrong (red glow) answer in reveal state; neutral border uses modern semi-transparent style.
- [hitstar] Shake animation on wrong answer moved from guessing screen to the card in reveal state.
- [hitstar] Switched backend track search from iTunes to Spotify API with OAuth2 client credentials token caching, market=DE filter, and `q=* year:1950-2025` query.
- [hitstar] Refactored GUESSING/REVEAL layout into top/middle/bottom sections: headline+exit+tracker pinned to top, card+audio centered vertically, year input pinned to bottom.
- [hitstar] Made HitstarCard fully responsive using `min()` and `aspect-ratio` instead of fixed pixel dimensions.
- [hitstar] Improved mobile layout: no horizontal or vertical scrollbars; components scale smaller on small screens.
- [frontend] Replaced `overflow: auto` on `main` with `overflow-x: hidden; overflow-y: auto` to prevent horizontal scrollbars.
- [jokes] Removed fixed height and margin from jokes container to avoid unwanted scroll areas.
- [global] Reduced GlobalMenu font sizes on mobile for better fit.
- [hitstar] Redesigned GUESSING/REVEAL UI: question headline + small danger Exit icon button in top bar, round progress tracker (gray/green/red bars), year input and submit icon button inline, submit icon centered via flex override.
- [global] Claude Code `/commit-push` Skill für automatisierten Commit-und-Push-Workflow.
- [global] Extend post-commit hook with Unicode gitmojis and additional keywords (test, style, update, improve, move, breaking, access, database, responsive, animation, i18n, clean).
- [frontend] Added `viewport-fit=cover` to enable iPhone safe-area support (Notch/Home-Indicator) across all pages.
- [memorandum] Empty state redesigned as Carbon Tile cards with title, description, and CTA buttons.
- [memorandum] FAB add-folder button is now `kind="primary"` and hidden in empty state.
- [memorandum] Folder and Link now show an `OverflowMenu` (kebab menu) on phone/tablet as alternative to right-click ContextMenu. Desktop keeps the existing ContextMenu unchanged.
- [todo] Edit button (pencil icon) added to Todo items on mobile as alternative to right-click ContextMenu.

### Fixed

- [memorandum] Race condition in cloud storage mode: subscribe handler now skips writes during initialization (`isInitialized` guard) to prevent overwriting server data with the empty default preset.
- [memorandum] `refreshPresetStore` was called twice on page mount (once via IIFE, once via `onMount`), causing duplicate concurrent loads and additional race conditions.
- [memorandum] Replaced Empty State flash during cloud data loading with Carbon skeleton cards, preventing the user from accidentally interacting with the empty-state buttons before data has loaded.
- [memorandum] `FolderOverlay` modal now has `hasScrollingContent` so sliders and inputs are scrollable on mobile.
- [memorandum] Folder arrow buttons on phone now have `min-height: 44px` touch target (was too small).
- [memorandum] FolderOverlay color value fields wrap on `$phone` instead of overflowing.
- [admin] Replaced `width: 100vw` with `width: 100%` in `.admin_sections` and `.admin_list_item_content` to prevent horizontal overflow past padding.
- [admin] FAB (`#update_admin_info_button`) now uses `env(safe-area-inset-bottom)` so it doesn't overlap the iPhone home indicator.
- [food-scan] `ContentOutput` image preview and text output use `max-width: 100%` on phone (were too narrow at 33vw/50vw).
- [food-scan] `DebugInformation` stats table is wrapped in `overflow-x: auto` to prevent horizontal overflow on mobile.
- [home] `JokeOfTheDay` date font-size increased from 0.65rem (10.4px) to 0.75rem (12px) to meet minimum readability threshold.
- [todo] `TodoInput` inputs stack vertically on phone with `flex-wrap: wrap` (were too narrow at ~147px).
- [todo] `TodoList` view toggle buttons and header toggle button have `min-height/min-width: 44px` on phone.
- [todo] `GenericListOverlay` delete button has `min-height/min-width: 44px` on phone.
- [todo] `Todo.svelte` title and category inputs have `font-size: 16px` on phone to prevent iOS Safari auto-zoom.
- [todo] Tab autocomplete hint hidden on phone (`display: none`) since mobile keyboards lack a Tab key.
- [settings] `OnlinePersistenceCheck` edit connection form wraps on phone so TextInput stacks above the button.
- [todo] Empty state button group (Neue Liste / Liste importieren) wraps on phone with `flex-wrap: wrap`.
- [global] All `height: Xvh` declarations now use double-declaration `Xvh; Xdvh` pattern for iOS Safari dynamic toolbar compatibility (`+layout.svelte`, `uno-sort`, `Jokes.svelte`, `AboutInfo.svelte`, `ToggledApplicationInfo.svelte`).
- [global] Background gradient `background-size` uses `100dvh` fallback so it covers the full dynamic viewport on iOS.

### Removed

- [global] Removed Chat application entirely (frontend route, API, stores, types and backend module/library).
- [home] Removed web search bar (`SearchBar`) and Settings button from home page.

### Changed

- [home] Navigation tiles show icon-only on phone; `JokeOfTheDay` section is now prominently displayed with a Carbon Tile card.
- [global] `GlobalMenu` footer shows GitHub/Stadtwerk buttons below "Developed by..." text on phone as social buttons.

### Changed

- [global] Replaced `height: 100vh` with `100dvh` (dynamic viewport height) in `.app` and settings page to fix iOS Browser-UI overlap.
- [global] Changed `main` width from `100vw` to `100%` to prevent horizontal scrollbar on mobile.
- [home] Fixed duplicate `@media #{$tablet}` bug in `SearchBar.svelte`; phone breakpoint now sets `margin-top: 2rem` and `width: 95vw` for a wider search bar.
- [global] `GlobalMenu` sidebar is now scrollable (`overflow-y: auto`) with padding to prevent footer overlap; footer respects safe-area-inset-bottom.
- [memorandum] Memorandum search bar uses `max-width: 100%` on phone (was 33vw ≈ 124px); menu line wraps on phone.
- [memorandum] Folder and link reorder buttons are always visible on phone/tablet (no longer hidden, only shown on hover).
- [memorandum] Link reorder buttons have a minimum touch-target of 44px height on phone.
- [todo] Edit container in `Todo.svelte` wraps on phone; title input takes full width.
- [memorandum] FAB add-folder button respects `safe-area-inset-bottom` on iPhone.
- [todo] FAB list-menu button respects `safe-area-inset-bottom` on iPhone.
- [global] Header `h2` uses `font-size: 1.2em` on phone for better fit.
- [global] Navigation touch-targets (`bx--content-switcher-btn`) have `min-height: 44px` on phone.
- [settings] `connection_card` uses `max-width: 100%` to prevent overflow on phone.
- [admin] Dashboard card description uses `font-size: 0.75rem` on phone (was unreadable 0.5rem/8px).
- [todo] Delete button in `GenericListOverlay` has minimum 32×32px touch-target.
- [home] Navigation margin-bottom reduced to `1rem` on phone/tablet (was 4rem/2rem).

### Fixed

- [frontend] Fixed `TypeError: Cannot read properties of undefined (reading 'de')` by replacing the non-reactive Proxy in `applications.ts` with a Svelte writable store initialized with proper default route values. All consumer components updated to use reactive store access (`$applicationRoutes`).

### Added

- [todo] Categories are now normalized (trimmed + lowercased) on write and on app start, so "Arbeit", "ARBEIT" and "arbeit" all map to "arbeit".
- [todo] Added `HistoryEntry` type `{ title, category }` replacing plain `string[]` history - category is now preserved when restoring from history.
- [todo] Added cleanup button to delete all completed todos at once and move them to history.
- [todo] History entries now show category in parentheses (e.g. `Milch (Einkaufen)`).
- [todo] Added store migration to convert legacy `string[]` history entries to `HistoryEntry[]` format on load.

### Changed

- [todo] History is now populated on **deletion** (not creation) of todos - entries include the todo's category.
- [todo] Duplicate history entries by title are replaced when re-deleted with updated category information.
- [backend] Updated `history` field in DTOs and Mongoose schemas from `string[]` to `HistoryEntry[]` with `title` and `category` properties.

- [shared] Added reusable EmojiPicker component with inline expandable dropdown, bilingual keyword search (EN/DE), scrollable grid view, and categorized emoji selection covering 200+ common emojis.
- [todo] Integrated EmojiPicker into todo list creation and edit modals with vertical layout for easier emoji selection.
- [todo] Added shared todo list functionality enabling collaborative editing via unique shared IDs.
- [todo] Added API module (`todo.api.ts`) for shared list operations following project patterns.
- [todo] Added "Make local" button to convert shared lists back to local-only mode.
- [todo] Added conflict resolution notifications when shared list is updated by another user.
- [todo] Added duplicate detection when importing already-imported shared lists.
- [todo] Added error notifications for failed shared list imports with localized messages.
- [todo] Added confirmation modal before deleting todo lists with separate warnings for local vs shared lists.
- [todo] Added server-side deletion for shared lists - when a shared list is deleted, it's removed from the backend.
- [todo] Added cross-user deletion detection - automatically removes shared lists from all users when deleted by another user.
- [todo] Added notification when a shared list is deleted by another user, with automatic list selection fallback.
- [todo] Added categories history tracking - all used categories are now stored in a persistent list similar to todo history.
- [todo] Added TodoCategories component displaying all categories with individual delete buttons and clear all functionality, positioned side-by-side with history on larger screens and stacked on mobile. Category tags and delete button are also responsive (side-by-side on desktop, stacked on mobile).
- [todo] Added Tab key autocomplete for category input fields using existing categories with visual hint showing matched category.
- [todo] Added click-to-insert functionality - clicking a category from the history inserts it into the focused category input field.
- [memorandum] Added "Copy link URL" option to link context menu for easy URL copying to clipboard.
- [memorandum] Added arrow-based reordering system with up/down buttons and "Move to Top/Bottom" context menu options for folders and links.
- [memorandum] Added editable preset overlay with JSON validation, allowing direct editing of preset configuration with real-time validation and sync to localStorage/cloud.
- [global] Added new setting to adjust background color if plain style is selected.

### Changed

- [todo] Added collapsible input section on mobile - a chevron toggle button next to the list name (visible only on phone) allows hiding/showing the History/Categories/Toggle/Input controls, giving more screen space to the todo list.
- [todo] Refactored history and categories from inline accordions to modal dialogs for cleaner UI and better mobile experience.
- [todo] Improved layout - todo list now takes remaining vertical space and scrolls independently with fixed header controls.
- [todo] Redesigned TodoInputSection as static section with modal trigger buttons instead of accordion.
- [todo] Refactored TodoItemList to display as modal component instead of inline accordion.
- [todo] Redesigned clear history and clear categories buttons - moved to modal with dedicated "Clear all" button.
- [backend] Updated all backend dependencies to latest compatible versions: NX 20.8.2 → 22.5.2, TypeScript 5.8.3 → 5.9.3, @swc/core 1.11.x → 1.15.13, NestJS packages to 11.1.14, Fastify 5.0.0 → 5.7.4, pino-http 10.2.0 → 11.0.0, cron 3.x → 4.4.0, and 50+ other packages.
- [backend] Upgraded Mongoose from 8.1.1 to 9.2.2 with complete API migration (FilterQuery → mongodb.Filter) across 10 files.
- [backend] Upgraded Jest from 29.7.0 to 30.2.0 with API migration (toThrowError → toThrow).
- [backend] Updated ESLint from 9.28.0 to 9.39.3 (latest 9.x compatible with NX).
- [backend] Updated @fastify/static from 8.3.0 to 9.0.0, @types/node from 22.15.21 to 22.19.11, and class-validator from 0.14.3 to 0.14.4.
- [shared] Refactored emoji data (keywords and categories) from inline component code into separate utility module (`frontend/src/lib/util/emoji-data.ts`) for better organization and reusability.
- [todo] Refactored backend architecture into three-layer design: `todo-persistence` (database layer), `todo-provider` (business logic), and `todo-controller` (API endpoints) for better separation of concerns and testability.
- [todo] Added comprehensive unit test coverage (39 tests) for all three layers with proper mocking and error handling.
- [todo] Renamed `TodoMongoDbService` to `TodoPersistenceService` and `TodoService` to `TodoProviderService` for clearer naming conventions.
- [todo] Cleaned up duplicate naming in module files: renamed `todo-todo-*.module.ts` to `todo-*.module.ts` and updated all class names and imports (e.g., `TodoTodoControllerModule` → `TodoControllerModule`).
- [todo] Replaced hardcoded "Uncategorized" category string with empty string throughout codebase - UI displays localized "General" / "Allgemein" label.
- [todo] Improved shared ID copy UI: icon-only button integrated with input field, success notification displayed at bottom of modal.
- [todo] Changed default view to category view (was: classic view) for better organization of todos.
- [todo] Added persistence for last viewed todo list - page reload now returns to the previously viewed list.
- [todo] Updated "Uncategorized" category label to more user-friendly "General" (EN) / "Allgemein" (DE).
- [todo] Improved TodoListOverlay modal UX by moving share/unshare button to modal action buttons and styling delete button as danger/red.
- [todo] Refactored shared list sync from push-based to pull-based polling (5-second intervals) for better conflict detection.
- [todo] Enhanced shared list creation to immediately push existing todos to server after creating shared list.
- [todo] Updated shared list endpoints to be public (no authentication required) for GET, POST, PUT, and DELETE operations.
- [todo] Improved sync logic with debounced updates and automatic conflict resolution via server-side version merging.
- [todo] Replaced inline fetch() calls with dedicated API module following project conventions.
- [todo] Updated API functions to return status codes for better error handling and 404 detection.
- [todo] Migrated todo route and all corresponding components (TodoList, TodoInput, Todo, TodoListOverlay, +page) to Svelte 5 runes syntax ($props, $state, $derived, $effect) for improved reactivity and type safety.
- [todo] Enhanced Todo component with improved UI/UX including clickable rows, better visual feedback, and proper accessibility.
- [todo] Improved TodoList with sorted todos (unchecked first), better state management using $derived, and enhanced history management.
- [todo] Enhanced TodoListOverlay with better form handling, proper state management, and automatic list selection after creation.
- [todo] Updated translations for global menu button text to be more descriptive.
- [food-scan] Migrated food-scan route and all corresponding components (FoodScan, ContentOutput, DebugInformation) to Svelte 5 runes syntax ($props, $state, $derived, $effect) for improved reactivity and type safety.
- [uno-sort] Migrated uno-sort route and ToggledApplicationInfo component to Svelte 5 runes syntax ($props, $state, $derived, $effect) for improved reactivity and type safety.
- [settings] Migrated settings route and all corresponding components (+page, SettingsDashboard, OnlinePersistenceCheck, ThemeSwitch, LanguageSwitch, BackgroundSwitch, IdentifierInformation) to Svelte 5 runes syntax ($props, $state, $derived, $effect) for improved reactivity and type safety.
- [home] Migrated home route and all corresponding components (+page, JokeOfTheDay, SearchBar) to Svelte 5 runes syntax ($props, $state, $derived, $effect) for improved reactivity and type safety.
- [jokes] Migrated jokes route and all corresponding components (Jokes, admin/Jokes, admin/jokes/+page) to Svelte 5 runes syntax ($props, $state, $derived, $effect) for improved reactivity and type safety.
- [admin] Migrated admin route and all corresponding components (Identifiers, Jokes, LinkPresets, Toggles, Activities, Dashboard) to Svelte 5 runes syntax ($props, $state, $derived, $effect) for improved reactivity and type safety.
- [admin] Converted event-based communication to callback props pattern for better type safety and maintainability.
- [memorandum] Migrated all memorandum components to Svelte 5 runes syntax ($props, $state, $derived, $effect) for improved reactivity and type safety.
- [frontend] Updated all dependencies to latest versions: Svelte 5.53.0, TypeScript 5.9.3, Vite 7.3.1, ESLint 9.39.3, Vitest 4.0.18, NX 22.5.2, SvelteKit 2.53.0, Carbon Components 0.101.0.
- [global] Upgraded to fastify version 5 and updated corresponding dependencies.
- [global] Replaced svelte material ui with carbon components.
- [memorandum] Added context menu for folders.
- [memorandum] Replaced drag-and-drop with arrow-based reordering for better reliability and mobile support.
- [global] Global menu now closes on link click.

### Removed

- [todo] Removed `amount` field from todo list entries completely - frontend types, components, input fields, translations, backend DTO, Mongoose schemas, and test data.
- [global] Removed Renovate bot - dependencies will be managed manually going forward.
- [memorandum] Removed drag-and-drop functionality for folders and links.

### Fixed

- [todo] Fixed double checkbox in todo items - removed redundant hidden native input that caused `todoChecked` to fire twice on click.
- [todo] Fixed History and Categories modals opening simultaneously - each modal now closes the other before opening.
- [todo] Fixed category click-to-insert from Categories modal not working - modal focus steal caused focus-based detection to fail; replaced with explicit context tracking (`lastCategoryInputContext`) captured before the modal opens.

- [frontend] Fixed Safari/iPhone "Cannot access uninitialized variable" error by refactoring applications.ts to eliminate top-level await and use Proxy pattern with async initialization.
- [backend] Fixed 5 security vulnerabilities through dependency updates (21 → 16 vulnerabilities, 24% reduction).
- [backend] Fixed TypeScript 5.9 stricter type checking in OCR service (Buffer → Uint8Array conversion for Blob constructor).
- [shared] Fixed EmojiPicker modal integration issues by replacing Carbon's Popover with a custom inline expandable dropdown that works reliably within modal constraints.
- [todo] Fixed missing sync when re-adding todos from history - now properly syncs to shared lists.
- [todo] Fixed bi-directional sync issue where changes in one browser didn't appear in other browsers - converted sync setup from onMount to reactive $effect.
- [todo] Fixed Toggle component error by converting `isCategoryView` from derived to state variable, enabling proper two-way binding.
- [todo] Fixed blank display in category view when list has no entries - now shows helpful empty state message.
- [todo] Fixed issue where no list was selected after deleting a list - now automatically selects the first remaining list.
- [todo] Fixed TOCTOU race condition in shared list updates by implementing atomic `findOneAndUpdate` with version check in query filter.
- [todo] Fixed generic error responses by replacing `throw new Error()` with NestJS HTTP exceptions (`NotFoundException`, `ConflictException`).
- [todo] Fixed missing history field persistence by adding to update DTO and MongoDB service signature.
- [todo] Fixed shared list deletion 400 error by removing manual UUID assignment and letting MongoDB auto-generate ObjectIds.
- [todo] Fixed DELETE request 400 error by removing Content-Type header from requests without body.
- [todo] Fixed cross-user deletion detection by adding global polling for all shared lists (every 10 seconds) in addition to per-list polling.
- [todo] Removed duplicate CSS blocks in TodoListOverlay component (`.share_section`, `.shared_id_container`, `.copy_button`, `.copied_notification`).
- [todo] Removed unused `importSharedId` state variable from TodoListOverlay component.
- [todo] Removed unused `selectRandomTagColor` function from TodoList component.
- [global] Fixed erroneous setLocale call in background color store causing i18n warnings.
- [memorandum] Fixed an issue where editing a folder in memorandum changed the wrong folders settings.
- [memorandum] Fixed folder ID duplication issues caused by drag-and-drop.
- [memorandum] Fixed incorrect folder and link positioning when reordering.
- [memorandum] Fixed masonry layout issue where folders stretched to full screen width when search resulted in a single folder.

## [1.0.3] - 2025-03-12

### Added
- [food-scan] MVP implementation with web llm and https://ocr.space/OCRAPI.
- [global] Added global theme switch functionality with local storage.
- [global] Light login functionality for every page to make tilloh.dev accessible to invited users.
- [memorandum] Autofocus on link search input field for a better UX.
- [global] Added dockerfiles to run the frontend, backend and database os independent with docker-compose

### Changed
- [global] Refactored css names to snake_case.
- [global] Implemented google material font locally.
- [food-scan] Second increment with follow up questions and camera input for mobile browsers.
- [global] Updated dark theme styling.
- [global] Refactored svelte store usage and corresponding code architecture.
- [settings] Changed the way users activate cloud persistence and updated info texts.
- [global] Refactored the way in which svelte stores are used in the app.

### Fixed
- [global] Language switch support fix for in-app texts.
- [global] Side nav bar css fix.

## [1.0.2] - 2024-12-18

### Added
- [global] Global language switch with local storage support.
- [memorandum] Link search input field with live results.
- [global] Renovate bot support for automating npm package updates.
- [global] Overhauled application appearance and rearranged UI components.
- [global] Unique logo for the project with favicon variants.
- [jokes] Ability to insert new jokes through form input and lookup random jokes by anyone.

### Changed
- [global] Enhanced readme documentation.

### Fixed

## [1.0.1] - 2024-09-01

### Added
- [global] Internalization of static frontend texts with `sveltekit-i18n` library supporting de and en locales.
- [admin] Admin panel for viewing metrics, managing toggles and approve jokes.
- [toggles] Global features toggle management using already existing key-value persistence.
- [backend] Unit tests for core features.

### Changed
- [global] Refactored frontend code architecture to improve readability.
- [uno-sort] Enhanced `uno-sort` component for better user experience.

### Fixed

## [1.0.0] - 2024-06-02

### Added
- [global] Initial project version setup including already existing features like memorandum, uno sort, lists, catch-em-all, settings and about me.
- [global] Automatic ci / cd pipeline with GitHub Actions.
- [global] Git hooks for pre-commit checks and post-commit gitmoji commit messages.

### Changed

### Fixed
