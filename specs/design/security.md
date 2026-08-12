# Security design

## Roles → permissions

No anonymous browsing before sign-in is out of scope to define further: per
Product Decisions, sign-in is required before checkout, but catalog browsing
(stories 1–3) does not itself require a role check — any signed-in user may
browse; the store admin's elevated actions are gated by role.

## Authentication (Thunder)

- Both `ceramics-webapp` and `ceramics-api` declare the SAME `thunder-app`
dependency, named `user-auth` — this shared name ties the SPA's sign-in
session to the bearer tokens `ceramics-api` validates.
- Scopes: default `openid profile email`.
- `ceramics-webapp` performs OIDC + PKCE sign-in in the browser and attaches
the resulting access token to every call to `ceramics-api`.
- `ceramics-api` sits behind the gateway, which validates the token and
injects the caller's identity header; `ceramics-api` never issues or
validates tokens itself.

## Role resolution

- `ceramics-api` resolves the caller's role from the identity the gateway
injects. The store has exactly two roles: `shopper` (default for any
signed-in user) and `store-admin` (an allow-listed set of accounts
configured for the single store owner and any staff).
- A caller with no resolvable role, or attempting a `store-admin`-only
operation without that role, is denied with `403 Forbidden` — deny by
default.