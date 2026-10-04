# Backend

## Components

### Memorandum API

The API that powers tilloh.dev Memorandum. Consists of generated identifiers for user sessions and a key-value store to store link information.

### (future) Chat API

The API that powers tilloh.dev Chat.

### (future) Todo API

The API that powers tilloh.dev Todo list.

## API documentation

The API documentation is available at `https://api.tilloh.dev/v1`

## Requirements

### Environment variables

Create a `.env` file in the root of the backend folder with the following variables:

```env
SERVER_ADDRESS="<address-identifier>" # default localhost, has to be 0.0.0.0 in docker-compose setup!
GLOBAL_PREFIX="v1" # default v1
PORT="<port-number>" # default 61154
MONGO_DB_URL="<mongodb-url>" # default mongodb://localhost/tilloh-dev
ADMIN_IDENTIFIER="<admin-identifier>" # from bitwarden
OCR_SPACE_URL="https://api.ocr.space/parse/image"
OCR_SPACE_API_KEY="<api-key>" # from bitwarden
```

## Development

1. Start mongodb

```
pnpm start:db
```

2. Start the backend

```
pnpm dev
```

### Nx generation

Generate a library

1. Run `nx g @nx/nest:library --name=foo --directory=/libs/foo/controller/foo/ "--tags=scope:my-app, type:controller"` to generate a library.
2. Use type:provider if library should be created
3. Answer "Which linter would you like to use?" with "eslint"
4. Answer "Which unit test runner would you like to use?" with "jest"

Libraries are shareable across libraries and applications.

- Code scaffolding
  Run `nx g @nx/nest:resource --name=my-resource --project=my-app` to generate crud endpoints for a resource.

# Deployment

## Automatically (uberspace)

1. Make changes to the backend code under `/backend`.
2. Push the changes to the repository `main` branch.
3. The changes will be automatically deployed to the server after manually confirming the deployment.

## Manually (uberspace)

1. Build the backend

```
pnpm build
```

2. Deploy the backend by coping the `dist/apps/tilloh-dev` folder content to the server in `/home/tilloh/api`
3. Copy the `package.json` file to the server in `/home/tilloh/api`
4. Install the dependencies in the server

```
ssh <username>@<uberspace-host>
cd /home/tilloh/api
npm install --production
```

5. Restart supervisor

```
supervisorctl stop tilloh-api-daemon
supervisorctl start tilloh-api-daemon
```

4. Check the logs

```
supervisorctl tail -f tilloh-api-daemon | npx pino-pretty
```

5. Find errors in stderr

```
supervisorctl tail tilloh-api-daemon stderr
```

## Alternative

See [docker-compose](../README.md#start-all-together) for an alternative deployment method using Docker Compose.

This method allows for easier management of dependencies and services, especially in environments where Docker is already in use. All necessary parts of the application are existent in the compose file. Only DNS settings need to be configured according to the selected cloud provider to finally match https://tilloh.dev.

# Websocket Documentation

As for now there is no easy possibility to get automated swagger documentation for websocket gateways.

The following events are available:

- `createMessage`: Creates a new message
- `findAllMessages`: Gets all the messages
- `findOneMessage`: Gets a single a message
- `updateMessage`: Updates a message
- `removeMessage`: Removes a message
- `join`: Let a user join a chat
- `typing`: Let a user know that another user is typing
