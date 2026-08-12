# Handmade Ceramics Store — PRD

## Problem Statement

Independent ceramics makers who sell handmade goods lack an easy way to present their catalog online and take orders. Today they rely on generic marketplaces or social media, which don't fit a single maker's brand, don't track limited one-off/small-batch stock well, and offer no dedicated checkout experience for buyers.

## Solution

A single-seller online store where a store admin lists handmade ceramic products with photos, descriptions, price, and stock, and shoppers browse the catalog, build a cart, sign in, and pay by card to complete a purchase. Shoppers receive an email confirmation and can review their order history.

## Actors

- **Shopper**: browses the catalog, searches/filters products, manages a cart, signs in, checks out with card payment, and views their own order history.
- **Store Admin**: manages the product catalog (create/edit/remove products, set stock quantity) and views incoming orders for fulfillment.

## User Stories

1. As a Shopper, I want to browse the product catalog, so that I can see what handmade ceramics are available.
2. As a Shopper, I want to view a product's details (photos, description, price, availability), so that I can decide whether to buy it.
3. As a Shopper, I want to search and filter products (e.g. by category or price), so that I can find items I'm interested in faster.
4. As a Shopper, I want to add products to a cart, so that I can collect items before checking out.
5. As a Shopper, I want to update quantities or remove items from my cart, so that I can adjust my order before paying.
6. As a Shopper, I want to sign in before checkout, so that my order is tied to my account.
7. As a Shopper, I want to pay for my order with a card, so that I can complete my purchase securely.
8. As a Shopper, I want to receive an email confirmation after placing an order, so that I have a record of my purchase.
9. As a Shopper, I want to view my past orders in my account, so that I can track what I've bought.
10. As a Store Admin, I want to create, edit, and remove products in the catalog, so that I can keep the store's offerings up to date.
11. As a Store Admin, I want to set and update the stock quantity for each product, so that sold-out items are automatically marked unavailable.
12. As a Store Admin, I want to view incoming orders, so that I can fulfill and ship them.

## Product Decisions

- Single-seller store: one store admin manages the entire catalog; this is not a multi-vendor marketplace.
- Every web app on the platform signs users in via SSO through Thunder, the platform IDP *(org default)*.
- Sign-in is required before checkout; there is no guest checkout path.
- Checkout accepts card payment via a payment gateway (e.g. Stripe).
- Stock is tracked per product; a product is automatically marked sold out / unavailable when its quantity reaches zero.
- Order confirmation is sent by email, and shoppers can view their order history in their account.

## Phasing

- **Phase 1 — Launch the handmade ceramics storefront**: deliver the full catalog browsing, cart, sign-in-gated checkout with card payment, order confirmation, order history, and admin catalog/inventory/order management. Stories: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12.

## Out of Scope

- Multi-vendor marketplace support (multiple independent sellers).
- Guest checkout.
- Product reviews and ratings.
- Returns and refunds workflows.
- Shipping rate calculation, multiple carriers, or international shipping.
- Wishlists, subscriptions, or recurring orders.
- Admin analytics/reporting dashboards beyond a basic order list.

## Open Questions

1. How is shipping cost determined at checkout (flat rate, free shipping, or calculated by weight/destination)? — deferred, does not block design.

## Further Notes

None.