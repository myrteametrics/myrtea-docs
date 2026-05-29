# General security principles

In Myrtea, security is built on the internet standard [JSON Web Tokens](https://jwt.io/). Two authentication modes are supported.

## Authentication modes

Set `AUTHENTICATION_MODE` in `config/engine-api.toml` (or the environment variable `MYRTEA_AUTHENTICATION_MODE`).

| Mode    | Description |
|---------|-------------|
| `BASIC` | (Default) Username/password authentication. The Engine API issues and validates JWTs. |
| `OIDC`  | OpenID Connect — delegates authentication to an external identity provider (e.g. Google, Keycloak). |

---

## BASIC authentication

### Authentication process

1. A request is sent (commonly from the frontend) to `POST /api/v5/login` with user credentials.
2. The Engine API validates the credentials against the PostgreSQL `users_v1` table.
3. If valid, a signed JWT is returned.
4. This JWT is added to every subsequent API request as an `Authorization: ****** header.
5. The Engine API validates the JWT on every request (signature, expiry, etc.).

### Relevant configuration keys

| Key | Default | Description |
|-----|---------|-------------|
| `HTTP_SERVER_API_ENABLE_SECURITY` | `"true"` | Set to `"false"` to disable all auth (dev only). |
| `JWT_SIGNING_KEY` | `""` | Secret used to sign JWTs. Auto-generated if empty in production mode. |
| `AUTHENTICATION_CREATE_SUPERUSER` | `"false"` | Create an `admin` / `myrtea` account on first run. |

!!! warning
    Always use HTTPS in production when `AUTHENTICATION_MODE = "BASIC"` — credentials are sent in the body of the login request.

---

## OIDC authentication

When `AUTHENTICATION_MODE = "OIDC"`, the Engine API acts as an OIDC client (relying party). Users are redirected to the identity provider and a JWT is issued after the callback.

### Authentication flow

1. The frontend redirects the user to `GET /api/v5/auth/oidc/login`.
2. The Engine API redirects to the identity provider's authorization endpoint.
3. After successful login, the IdP redirects to `AUTHENTICATION_OIDC_REDIRECT_URL`.
4. The Engine API exchanges the code for tokens, validates them, and redirects to `AUTHENTICATION_OIDC_FRONT_END_URL` with a Myrtea JWT.
5. All subsequent API calls use this JWT as usual.

### Relevant configuration keys

| Key | Default | Description |
|-----|---------|-------------|
| `AUTHENTICATION_OIDC_ISSUER_URL` | `"https://accounts.google.com"` | OIDC provider base URL. |
| `AUTHENTICATION_OIDC_CLIENT_ID` | `""` | Client ID registered with the identity provider. |
| `AUTHENTICATION_OIDC_CLIENT_SECRET` | `""` | Client secret. Keep this confidential. |
| `AUTHENTICATION_OIDC_REDIRECT_URL` | `"http://127.0.0.1:9000/api/v5/auth/oidc/callback"` | Must match the redirect URI configured at the provider. |
| `AUTHENTICATION_OIDC_FRONT_END_URL` | `"http://127.0.0.1:4200"` | Where the user is sent after successful auth. |
| `AUTHENTICATION_OIDC_SCOPES` | `"profile,email,roles"` | Requested OIDC scopes. |
| `AUTHENTICATION_OIDC_ENCRYPTION_KEY` | `"thisis24characterslongs."` | AES key (16, 24 or 32 chars) for state encryption. Change in production. |

---

## Gateway mode

Set `HTTP_SERVER_API_ENABLE_GATEWAY_MODE = "true"` to trust JWTs that have already been validated upstream by an API gateway. The Engine API will not re-validate token signatures in this mode.

---

## API keys

In addition to JWT-based auth, the Engine API supports long-lived API keys for service-to-service calls. Keys are managed via:

```
GET    /api/v5/admin/security/apikey
POST   /api/v5/admin/security/apikey
PUT    /api/v5/admin/security/apikey/{id}
DELETE /api/v5/admin/security/apikey/{id}
POST   /api/v5/admin/security/apikey/{id}/deactivate
```

API keys are passed in the `X-API-Key` header.

Cache duration is controlled by `API_KEY_CACHE_DURATION` (default `"1h"`).

---

## Roles and permissions

The Engine API implements role-based access control (RBAC):

- **Users** are assigned one or more **roles**.
- **Roles** are granted one or more **permissions**.
- Permissions control access to specific API resources.

Admin endpoints (`/api/v5/admin/security/...`) manage users, roles, and permissions.
