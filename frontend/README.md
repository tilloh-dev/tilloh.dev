# Frontend

## Application

The svelte frontend is available at `https://tilloh.dev`.

## Toggles

There are a few usable toggles in the frontend. These can be created in the admin panel under `Toggles`. The following toggles are available (see `TogglesEnum`):

1. **TOGGLE_RANDOM_JOKE**: Show a random joke on the home page.
2. **TOGGLE_NAV_MEMORANDUM**: Show the memorandum button in the navigation bar and activate route.
3. **TOGGLE_NAV_TODO**: Show the todo button in the navigation bar and activate route.
4. **TOGGLE_NAV_CHAT**: Show the chat button in the navigation bar and activate route.
5. **TOGGLE_NAV_CATCH_EM_ALL**: Show the catch em all button in the navigation bar and activate route.
6. **TOGGLE_NAV_UNO_SORT**: Show the uno sort button in the navigation bar and activate route.
7. **TOGGLE_NAV_ABOUT**: Show the about button in the navigation bar and activate route.
8. **TOGGLE_ADMIN_DASHBOARD**: Show the dashboard in admin panel.
9. **TOGGLE_ADMIN_ACTIVITIES**: Show the activities in admin panel.
10. **TOGGLE_ADMIN_IDENTIFIERS**: Show the identifiers in admin panel.
11. **TOGGLE_ADMIN_LINK_PRESETS**: Show the link presets in admin panel.

## Development

1. Install dependencies.

```
cd frontend
pnpm install
```

2. Start the development server.

```
cd frontend
pnpm dev
```

3. Open the browser at `http://localhost:5173`.
4. Make changes to the frontend code and see the changes in the browser.
5. Press `strg + c` to stop the server.

### Folder Structure

- `static`: Place your static files like images and favicons in here.
- `routes`: Contains the routes of the frontend. Each route is a separate `page.svelte` file and uses svelte lib components.
- `lib`: Contains the source code of the frontend.
  - `api`: Contains api http requests for the corresponding backend endpoints.
  - `components`: Contains the reusable svelte components.
  - `config`: Contains the application configurations.
  - `styles`: Contains the shared style to be used in all svelte components.
  - `types`: Contains the shared types to be used in all svelte components.
  - `util`: Contains the utility functions of the frontend.

### i18n internationalization

The frontend uses the `sveltekit-i18n` library for internationalization. The translations are stored in the `src/lib/config/` folder. The translations are loaded in the `src/lib/util/translations.ts` file. The translations are used in the svelte components with the `t` function. There is also a initialization check with `{#if $initialized}` svelte condition block.

# Deployment

## Automatically

1. Make changes to the frontend code under `/frontend`.
2. Push the changes to the repository `main` branch.
3. The changes will be automatically deployed to the server.

## Manually

1. Build the frontend artifact

```
pnpm build
```

2. Deploy the frontend by coping the `dist` folder content to the server in `/home/tilloh/html`.
3. Reload website with Strg + F5.
