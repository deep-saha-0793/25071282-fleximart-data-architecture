# FlexiMart Database Schema Documentation

## ENTITY: customers
Purpose: Stores customer information for the FlexiMart platform.

Attributes:
- customer_id: Unique identifier for each customer (Primary Key)
- first_name: Customer's first name
- last_name: Customer's last name
- email: Unique email address of the customer
- phone: Customer contact number in standardized format
- city: City where the customer resides
- registration_date: Date of customer registration

Relationships:
- One customer can place MANY orders (1:M relationship with orders table)

## ENTITY: products
Purpose: Stores product catalog details.

Attributes:
- product_id: Unique identifier for each product (Primary Key)
- product_name: Name of the product
- category: Product category
- price: Unit price of the product
- stock_quantity: Available inventory count

Relationships:
- Products can be referenced by MANY orders through order_items (logical relationship)

## ENTITY: orders
Purpose: Stores sales transaction information.

Attributes:
- order_id: Unique identifier for each order (Primary Key)
- customer_id: Reference to the customer who placed the order (Foreign Key)
- order_date: Date when the order was placed
- total_amount: Total monetary value of the order
- status: Status of the order (Completed, Pending, Cancelled)

Relationships:
- Each order belongs to ONE customer
- Each order may contain ONE or MORE order items

## ENTITY: order_items
Purpose: Stores product-level details for each order to support multi-item orders.

Attributes:
- order_item_id: Unique identifier (Primary Key)
- order_id: References the related order (Foreign Key)
- product_id: References the product (Foreign Key)
- quantity: Number of units ordered
- unit_price: Price per unit at the time of purchase
- subtotal: quantity × unit_price

Relationships:
- MANY order_items belong to ONE order
- MANY order_items reference ONE product


## Normalization Explanation (Third Normal Form)

The FlexiMart database schema is designed in Third Normal Form (3NF) to minimize redundancy and ensure data integrity. Each table represents a distinct business entity, and all non-key attributes are functionally dependent on the primary key.

In the customers table, attributes such as first_name, last_name, email, phone, city, and registration_date depend solely on customer_id. There are no partial or transitive dependencies, ensuring customer updates do not introduce inconsistencies.

The products table stores product-specific details, where attributes like product_name, category, price, and stock_quantity depend only on product_id. Product data is separated from transactional data, avoiding duplication across sales records.

The orders table captures transaction-level information and maintains a foreign key relationship with customers. Attributes including order_date, total_amount, and status depend only on order_id, ensuring proper normalization.

The order_items table resolves the many-to-many relationship between orders and products. Each row represents a single product within an order, and attributes such as quantity, unit_price, and subtotal depend entirely on order_item_id.

This design prevents update anomalies by isolating entity data, avoids insert anomalies by allowing independent entity creation, and eliminates delete anomalies by maintaining referential integrity across tables.
