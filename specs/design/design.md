# Handmade Ceramics Store — Design

## Overview

The store is a single-seller e-commerce system made of one React SPA
(`ceramics-webapp`) and one Ballerina backend (`ceramics-api`). The SPA serves
both the Shopper storefront (catalog, cart, checkout, order history) and the
Store Admin console (catalog and stock management, order fulfillment view),
gated by role after Thunder SSO sign-in. The API owns all product, cart,
order, payment, and notification logic behind a single Postgres-backed
service, calls a payment gateway to process card payments, and sends order
confirmation email through an email provider.

## Context (C1)

```mermaid
graph TD
    shopper((Shopper))
    admin((Store Admin))
    webapp[Ceramics Storefront<br/>web-application]
    api[Ceramics API<br/>service]
    auth[[Thunder Auth]]
    payment[[Payment Provider]]
    email[[Email Provider]]

    shopper -->|browses, buys| webapp
    admin -->|manages catalog & orders| webapp
    webapp --> api
    webapp -.sign-in.-> auth
    api -.validates token.-> auth
    api -->|charges card| payment
    api -->|sends confirmation| email
```

## Domain model (ER)

```mermaid
erDiagram
    USER ||--o| CART : has
    USER ||--o{ ORDER : places
    CART ||--o{ CART_ITEM : contains
    PRODUCT ||--o{ CART_ITEM : "referenced by"
    ORDER ||--o{ ORDER_ITEM : contains
    PRODUCT ||--o{ ORDER_ITEM : "referenced by"

    USER {
        string id
        string email
        string role
    }
    PRODUCT {
        string id
        string name
        string description
        string category
        decimal price
        int stockQuantity
        string[] photoUrls
        boolean available
    }
    CART {
        string id
        string userId
    }
    CART_ITEM {
        string id
        string cartId
        string productId
        int quantity
    }
    ORDER {
        string id
        string userId
        string status
        decimal total
        string paymentIntentId
        datetime placedAt
    }
    ORDER_ITEM {
        string id
        string orderId
        string productId
        int quantity
        decimal unitPrice
    }
```

## Key flows

### Shopper: browse, cart, and checkout

```mermaid
sequenceDiagram
    actor Shopper
    participant Webapp as Ceramics Storefront
    participant Api as Ceramics API
    participant Auth as Thunder Auth
    participant Pay as Payment Provider
    participant Mail as Email Provider

    Shopper->>Webapp: Browse / search catalog
    Webapp->>Api: GET /products
    Api-->>Webapp: product list (with stock)
    Shopper->>Webapp: Add product to cart
    Webapp->>Api: POST /cart/items
    Shopper->>Webapp: Go to checkout
    Webapp->>Auth: Sign in (OIDC + PKCE)
    Auth-->>Webapp: ID/access token
    Webapp->>Api: POST /orders (with token)
    Api->>Auth: Validate token
    Api->>Pay: Charge card
    Pay-->>Api: Payment confirmed
    Api->>Api: Decrement stock, create order
    Api->>Mail: Send order confirmation
    Api-->>Webapp: Order confirmed
    Webapp-->>Shopper: Order confirmation screen
```

### Store Admin: manage catalog and stock

```mermaid
sequenceDiagram
    actor Admin as Store Admin
    participant Webapp as Ceramics Storefront
    participant Api as Ceramics API
    participant Auth as Thunder Auth

    Admin->>Webapp: Sign in
    Webapp->>Auth: OIDC + PKCE
    Auth-->>Webapp: token (admin role)
    Admin->>Webapp: Create/edit product, set stock
    Webapp->>Api: POST/PUT /products (with token)
    Api->>Auth: Validate token + role
    Api->>Api: Persist product, mark sold-out at 0 stock
    Api-->>Webapp: Updated product
    Admin->>Webapp: View incoming orders
    Webapp->>Api: GET /orders (admin scope)
    Api-->>Webapp: order list
```