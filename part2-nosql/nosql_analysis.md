# NoSQL Database Analysis – FlexiMart

## Section A: Limitations of RDBMS (150 Words)

Relational databases like MySQL are designed with a fixed schema, which makes them less suitable for handling highly diverse product data. In FlexiMart’s case, products such as laptops, smartphones, clothing, and footwear have very different attributes. Representing these variations in an RDBMS would require creating many optional columns or multiple related tables, leading to complex joins and sparse data.  

Frequent schema changes are another limitation. Each time a new product type is introduced with new attributes (for example, adding “battery_capacity” for electronics or “fabric_type” for clothing), the relational schema must be altered, which is costly and risky in production environments.  

Additionally, storing customer reviews in an RDBMS is inefficient. Reviews require separate tables and foreign keys, resulting in multiple joins to fetch a product with its reviews. This increases query complexity and negatively impacts performance, especially when reviews grow in volume.

---

## Section B: Benefits of NoSQL (MongoDB) (150 Words)

MongoDB addresses these challenges through its flexible, document-based data model. Each product can be stored as a JSON document with its own structure, allowing electronics and fashion products to have different attributes without enforcing a rigid schema. This makes MongoDB ideal for handling evolving and diverse product catalogs.  

MongoDB also supports embedded documents, which allows customer reviews to be stored directly within the product document. As a result, retrieving a product along with its reviews becomes a single read operation, improving performance and simplifying application logic.  

Furthermore, MongoDB is designed for horizontal scalability. It can easily scale across multiple servers using sharding, making it well-suited for large e-commerce platforms like FlexiMart that may experience rapid growth in products and user interactions. These features make MongoDB a strong choice for managing flexible, high-volume product data.

---

## Section C: Trade-offs of Using MongoDB (100 Words)

One disadvantage of MongoDB compared to MySQL is weaker support for complex transactions across multiple collections. While MongoDB supports transactions, relational databases still provide stronger guarantees for multi-table transactional consistency.  

Another trade-off is data redundancy. Since MongoDB encourages embedding data, information such as reviews or category details may be duplicated across documents, increasing storage usage. Additionally, enforcing strict data integrity rules is more challenging in MongoDB compared to relational databases, which rely on constraints like foreign keys.
