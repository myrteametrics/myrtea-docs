# Administration

The **Administration** domain (`src/app/features/administration`) covers user management, access control, and API authentication.

## User

Path: `components/user`

Standard user management. Each user account has:

| Field | Description |
|-------|-------------|
| Login | Unique username |
| Password | Hashed on the backend — never stored in plain text |
| Roles | One or more roles assigned to the user |

Users authenticate against the Engine API via the `/login` endpoint (BASIC mode) or through an OIDC provider.

## Role

Path: `components/role`

A **role** is a named collection of permissions. Assigning a role to a user grants all the permissions bundled in that role.

Roles allow managing access at a group level instead of configuring permissions individually per user.

## Permission

Path: `components/permission`

**Permissions** are the atomic access-control units. Each permission controls access to a specific resource and action combination.

Permissions are grouped into roles and roles are assigned to users or API keys.

!!! note
    The complete list of available permissions depends on the Engine API version deployed. Refer to the Engine API Swagger UI (`/swagger/index.html`) for the exhaustive resource catalogue.

## API Key

Path: `components/apikey`

**API keys** allow service-to-service or script-based authentication without a user session. Each key:

- Has a **unique name** for identification
- Is assigned one or more **roles** (same role system as regular users)
- Can be **revoked** at any time without affecting other keys or users

!!! warning
    API keys are displayed only once at creation time. Store the key value securely — it cannot be retrieved afterwards from the UI.

Use API keys for automated pipelines, monitoring agents, or any headless integration that needs to call the Engine API.
