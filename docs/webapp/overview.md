# Settings Webapp Overview

The **myrtea-webapp-settings** is the Angular 21 frontend application used to configure and manage a Myrtea supervision platform. It communicates exclusively with the [Engine API](https://github.com/myrteametrics/myrtea-engine-api) through its REST interface (`/api/v5`).

## Purpose

The webapp is a **settings application** — its role is to let operators configure the full supervision system without writing code or calling APIs directly. It covers three main domains:

| Domain | Description |
|--------|-------------|
| [Business Settings](business-settings.md) | Core supervision logic — models, facts, situations, rules, scheduler, calendars, tags, templates, variables |
| [Technical Settings](technical-settings.md) | Infrastructure configuration — connectors, Elasticsearch, external configs, service manager |
| [Administration](administration.md) | User management — users, roles, permissions, API keys |

## Technology Stack

| Technology | Version |
|------------|---------|
| TypeScript | ~5.9 |
| Angular | 21 |
| Angular Material | 21 |
| Bootstrap | ~4.3 |
| ApexCharts | 5.x |
| RxJS | ~7.8 |

## Customization Model

The webapp is designed as a **template foundation** for multiple client applications.

Each custom application:

1. **Forks** the base `myrtea-webapp-settings` project
2. Implements its specific logic inside `src/app/custom/`
3. Stays synchronized with the base project ("socle") for core updates

The `src/app/custom/` directory is the **only** area that should be modified in derived projects. Everything outside of it is reserved for upstream core updates.

```
src/app/
├── core/               # Core services, guards, interceptors
├── features/
│   ├── settings-business/    # Business settings components
│   ├── settings-technical/   # Technical settings components
│   └── administration/       # User & access management
├── shared/             # Shared UI components, directives, pipes, constants
└── custom/             # ← Only this directory is modified per project
    ├── components/
    ├── services/
    ├── models/
    ├── custom-routing.ts
    ├── custom-module.ts
    └── custom.scss
```

## Getting Started (Development)

### Prerequisites

- Node.js 20+
- pnpm 10+
- Angular CLI 21

### Install & Run

```bash
pnpm install
pnpm start
```

For a specific environment:

```bash
pnpm start:dev
```

### Lint

```bash
pnpm run lint
```

### Build

```bash
pnpm run build
```

## Authentication

The webapp authenticates against the Engine API using JWT tokens issued by the `/login` endpoint. It forwards the JWT in the `Authorization: Bearer <token>` header on all subsequent requests.

When OIDC is configured on the Engine API side, the webapp delegates the login flow to the configured identity provider.

See [Security](../security/general.md) for details on authentication modes.
