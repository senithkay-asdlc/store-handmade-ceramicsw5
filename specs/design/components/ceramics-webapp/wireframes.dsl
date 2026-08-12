// Handmade Ceramics Store — Shopper storefront + Store Admin console

screen ProductCatalog "Shoppers browse and search the handmade ceramics catalog"
  navbar "Ceramics | Shop -> ProductCatalog | Cart -> Cart | My Orders -> OrderHistory | Admin -> AdminProducts"
  row
    heading "Handmade Ceramics"
    right
    search "Search mugs, bowls, vases…"
    select "Category: All"
  row
    card "Glazed Stoneware Mug | $28 | Blue speckle glaze" -> ProductDetail
    card "Wide Ceramic Bowl | $42 | Matte white, 9in" -> ProductDetail
    card "Tall Vase | $65 | Terracotta, hand-thrown" -> ProductDetail
  row
    card "Espresso Cup Set | $36 | Set of 2, sage green" -> ProductDetail
    card "Dinner Plate | $22 | Speckled cream" -> ProductDetail
    card "Sold Out — Serving Platter | $58 | Currently unavailable"

screen ProductDetail "A shopper reviews one product before adding it to the cart"
  navbar "Ceramics | Shop -> ProductCatalog | Cart -> Cart | My Orders -> OrderHistory | Admin -> AdminProducts"
  breadcrumb "Shop / Glazed Stoneware Mug"
  split 60/40
    left
      image "Product photo"
      text "Glazed Stoneware Mug — hand-thrown, blue speckle glaze, holds 12oz."
    right
      heading "$28"
      badge "In stock" success
      text "8 left"
      select "Quantity: 1"
      button "Add to cart" primary -> Cart

screen Cart "Shopper reviews items before checking out"
  navbar "Ceramics | Shop -> ProductCatalog | Cart -> Cart | My Orders -> OrderHistory | Admin -> AdminProducts"
  heading "Your Cart"
  table "Product | Price | Quantity | Subtotal"
    row "Glazed Stoneware Mug | $28 | 2 | $56"
    row "Tall Vase | $65 | 1 | $65"
  row
    right
    text "Total: $121"
  row
    right
    button "Continue shopping"
    button "Checkout" primary -> Checkout

screen Checkout "Signed-in shopper pays by card to place the order"
  navbar "Ceramics | Shop -> ProductCatalog | Cart -> Cart | My Orders -> OrderHistory | Admin -> AdminProducts"
  heading "Checkout"
  text "Signed in as jane@example.com"
  card "Order summary"
    text "Glazed Stoneware Mug x2 — $56"
    text "Tall Vase x1 — $65"
    text "Total: $121"
  input "Card number"
  row
    input "Expiry MM/YY"
    input "CVC"
  row
    right
    button "Cancel"
    button "Pay $121" primary -> OrderConfirmation

screen OrderConfirmation "Shopper sees their order was placed successfully"
  navbar "Ceramics | Shop -> ProductCatalog | Cart -> Cart | My Orders -> OrderHistory | Admin -> AdminProducts"
  heading "Order confirmed"
  badge "Paid" success
  text "Order #10482 — a confirmation email is on its way to jane@example.com"
  table "Product | Quantity | Price"
    row "Glazed Stoneware Mug | 2 | $56"
    row "Tall Vase | 1 | $65"
  button "View my orders" primary -> OrderHistory

screen OrderHistory "Shopper reviews their past orders"
  navbar "Ceramics | Shop -> ProductCatalog | Cart -> Cart | My Orders -> OrderHistory | Admin -> AdminProducts"
  heading "My Orders"
  table "Order | Date | Status | Total"
    row "#10482 | Aug 12, 2026 | Paid | $121"
    row "#10311 | Jul 28, 2026 | Paid | $42"

screen AdminProducts "Store Admin manages the catalog and stock levels"
  navbar "Ceramics | Shop -> ProductCatalog | Cart -> Cart | My Orders -> OrderHistory | Admin -> AdminProducts"
  row
    heading "Manage Products"
    right
    button "New product" primary -> AdminProductForm
  table "Product | Price | Stock | Status" -> AdminProductForm
    row "Glazed Stoneware Mug | $28 | 8 | In stock"
    row "Tall Vase | $65 | 3 | In stock"
    row "Serving Platter | $58 | 0 | Sold out"

screen AdminProductForm "Store Admin creates or edits one product, including stock"
  navbar "Ceramics | Shop -> ProductCatalog | Cart -> Cart | My Orders -> OrderHistory | Admin -> AdminProducts"
  breadcrumb "Admin / Products / Glazed Stoneware Mug"
  heading "Edit Product"
  input "Name — e.g. Glazed Stoneware Mug"
  textarea "Description"
  row
    select "Category: Mugs"
    input "Price"
  input "Stock quantity"
  row
    right
    button "Delete"
    button "Save product" primary -> AdminProducts

screen AdminOrders "Store Admin reviews incoming orders to fulfill and ship"
  navbar "Ceramics | Shop -> ProductCatalog | Cart -> Cart | My Orders -> OrderHistory | Admin -> AdminProducts"
  heading "Incoming Orders"
  tabs "All | Paid | Failed"
  table "Order | Customer | Date | Total | Status"
    row "#10482 | jane@example.com | Aug 12, 2026 | $121 | Paid"
    row "#10311 | tomo@example.com | Jul 28, 2026 | $42 | Paid"
