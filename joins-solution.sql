## Tasks

1. Get all customers and their addresses.
SELECT "customers"."first_name", "customers"."last_name", "addresses"."street", "addresses"."city"
FROM "customers"
JOIN "addresses" ON "customers"."id" = "addresses"."customer_id";

2. Get all orders and their line items (orders, quantity and product).
SELECT "line_items"."order_id", "line_items"."quantity", "line_items"."product_id", "products"."description"
FROM "line_items"
JOIN "orders" ON "orders"."id" = "line_items"."order_id"
JOIN "products" ON "line_items"."product_id" = "products"."id";


3. Which warehouses have cheetos?
-- "warehouse"."product"."id"
-- "products"."description" = 'cheetos'
SELECT "products"."id", "products"."description", "warehouse"."warehouse"
FROM "products"
JOIN "warehouse_product" ON "warehouse_product"."product_id" = "products"."id"
JOIN "warehouse" ON "warehouse"."id" = "warehouse_product"."warehouse_id"
WHERE "products"."description" = 'cheetos';



4. Which warehouses have diet pepsi?
SELECT "products"."id", "products"."description", "warehouse"
FROM "products"
JOIN "warehouse_product" ON "warehouse_product"."product_id" = "products"."id"
JOIN "warehouse" ON "warehouse"."id" = "warehouse_product"."warehouse_id"
WHERE "products"."description" = 'diet pepsi';



5. Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
SELECT "customers"."first_name", count("orders") 
FROM "customers" 
JOIN "addresses" ON "addresses"."customer_id" = "customers"."id"
JOIN "orders" ON "orders"."address_id" = "addresses"."id"
GROUP BY "customers"."first_name";



6. How many customers do we have?
SELECT count(*) AS "Total Customers" FROM "customers" ;



7. How many products do we carry?
SELECT count(*) FROM "products";



8. What is the total available on-hand quantity of diet pepsi?
SELECT SUM("line_items"."quantity") AS "Total Diet Pepsi on Hand"
FROM "products"
JOIN "line_items" ON "line_items"."order_id" = "products"."id"
WHERE "products"."description" = 'diet pepsi';

