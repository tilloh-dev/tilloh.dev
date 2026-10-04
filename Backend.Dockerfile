FROM node:22-alpine

WORKDIR /app

COPY backend/dist/apps/tilloh-dev /app
COPY backend/package.json /app

# No lockfile in the image: the repo uses a pnpm workspace lockfile, the
# runtime installs from package.json like the Uberspace host does.
# npm itself is not needed at runtime and brings its own vulnerable deps.
RUN npm install --omit=dev --legacy-peer-deps \
    && rm -rf /usr/local/lib/node_modules/npm /usr/local/bin/npm /usr/local/bin/npx

EXPOSE 61154

CMD ["node", "main.js"]
