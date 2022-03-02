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

SELECT "products"."id", "products"."description", "warehouse"
FROM "products"
JOIN "warehouse_product" ON "warehouse_product"."product_id" = "products"."id"
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


7. How many products do we carry?
SELECT count(*) FROM "products";

8. What is the total available on-hand quantity of diet pepsi?







CREATE TABLE "person" (
"id" SERIAL PRIMARY KEY,
"name" VARCHAR(100) NOT NULL
);

CREATE TABLE "social-security" (
"id" SERIAL PRIMARY KEY,
"person_id" INT REFERENCES "person",
"number" INT NOT NULL
);

INSERT INTO "person" ("name") 
VALUES ('Mark');

INSERT INTO "social-security" ("person_id", "number")
VALUES (1, 12345);

SELECT * FROM "person"
JOIN "social-security" ON "person"."id" = "social-security"."person_id"
WHERE "person"."name" = 'Mark';


CREATE TABLE "cohort" (
"id" SERIAL PRIMARY KEY,
"name" VARCHAR(25),
"start_date" DATE
);


CREATE TABLE "student" (
"id" SERIAL PRIMARY KEY,
"cohort_id" INT REFERENCES "cohort",
"name" VARCHAR(100) NOT NULL
);

INSERT INTO "cohort" ("name", "start_date")
VALUES ('Adams', '11-29-2021');

INSERT INTO "cohort" ("name", "start_date")
VALUES ('Butler', '2-28-2022');

INSERT INTO "cohort" ("name", "start_date")
VALUES ('Xi', '06-06-2016');

INSERT INTO "student" ("cohort_id", "name")
VALUES (1, 'Mark'), (1, 'Adam'), (2, 'Juliette'), (3, 'Liz');

SELECT * FROM "cohort";
SELECT * FROM "student";


SELECT count(*) FROM "student"
JOIN "cohort" ON "cohort"."id" = "student"."cohort_id";
WHERE "cohort"."name" = 'Adams';


-- sum() adds selected fields together

SELECT "cohort"."name", count(*) FROM "cohort"
JOIN "student" ON "cohort"."id" = "student"."cohort_id"
GROUP BY "cohort"."name"
ORDER BY "cohort"."name" DESC; --ASC default, or DESC

CREATE TABLE "human" (
"id" SERIAL PRIMARY KEY,
"name" VARCHAR(50)
);


INSERT INTO "human" ("name")
VALUES ('Koffi'), ('Liz'), ('Brant'), ('Andy'), ('Drew');

SELECT * FROM "human";

CREATE TABLE "hobby"(
"id" SERIAL PRIMARY KEY,
"description" VARCHAR(100)
);

INSERT INTO "hobby" ("description")
VALUES ('kyaking'),('drawing'), ('duck tape crafts'), ('tech deck kick flips'), ('cardboard and paper crafts'), ('widdling'), ('coding');

SELECT * FROM "hobby";

CREATE TABLE "human_hobby" (
"id" SERIAL PRIMARY KEY,
"human_id" INT REFERENCES "human",
"hobby_id" INT REFERENCES "hobby",
"skill" INT 
);


INSERT INTO "human_hobby" ("human_id", "hobby_id", "skill")
VALUES (5, 2, 3), (5, 3, 2), (5, 5, 5),
(4, 4, 2), (4, 5, 2), (2, 7, 1), (2, 6, 3),
(3, 2, 2), (3, 6, 1), (3, 5, 3), (1, 7, 2);

SELECT "human"."name", "hobby"."description" as "FUN-TINGS"
FROM "human"
JOIN "human_hobby" ON "human"."id" = "human_hobby"."human_id"
JOIN "hobby" ON "human_hobby"."hobby_id" = "hobby"."id"
WHERE "human"."name" = 'Brant';


SELECT count(*) as "total_humans" FROM "human";

SELECT MIN("skill") FROM "human_hobby";

SELECT MAX("skill") FROM "human_hobby";

SELECT AVG("skill"), "human"."name"
FROM "human_hobby"
JOIN "human" ON "human"."id" = "human_hobby"."human_id"
GROUP BY "human"."name";


SELECT SUM("skill") AS "total_skill" FROM "human_hobby";

SELECT "hobby"."description", count("human_hobby"."hobby_id") AS "the count"
FROM "hobby"
JOIN "human_hobby" ON "hobby"."id" = "human_hobby"."hobby_id"
GROUP BY "hobby"."Description"
ORDER BY "the count";