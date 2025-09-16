# 📘 Data Catalog – Gold Layer

## **Overview**

The **Gold Layer** represents the business-level data model, optimized for analytics and reporting. It integrates cleansed and conformed data into **dimension tables** and **fact tables** to support consistent business intelligence and decision-making.

---

### **1. gold.dim\_customers**

**Purpose:** Stores detailed customer information, enriched with demographic and geographic attributes.

**Columns:**

| Column Name       | Data Type    | Description                                                                           |
| ----------------- | ------------ | ------------------------------------------------------------------------------------- |
| `customer_key`    | INT          | Surrogate key uniquely identifying each customer record in the dimension table.       |
| `customer_id`     | INT          | Unique identifier assigned to each customer.                                          |
| `customer_number` | NVARCHAR(50) | Alphanumeric identifier representing the customer, used for tracking and referencing. |
| `first_name`      | NVARCHAR(50) | The customer's given name.                                                            |
| `last_name`       | NVARCHAR(50) | The customer's family name.                                                           |
| `country`         | NVARCHAR(50) | The country of residence (e.g., *Australia*).                                         |
| `marital_status`  | NVARCHAR(50) | Customer’s marital status (e.g., *Married*, *Single*).                                |
| `gender`          | NVARCHAR(50) | Gender of the customer (e.g., *Male*, *Female*, *n/a*).                               |
| `birthdate`       | DATE         | Customer’s date of birth in `YYYY-MM-DD` format.                                      |
| `create_date`     | DATE         | Date when the customer record was created in the system.                              |

---

### **2. gold.dim\_products**

**Purpose:** Provides descriptive details and classification attributes for products.

**Columns:**

| Column Name            | Data Type    | Description                                                          |
| ---------------------- | ------------ | -------------------------------------------------------------------- |
| `product_key`          | INT          | Surrogate key uniquely identifying each product record.              |
| `product_id`           | INT          | Unique identifier assigned to each product.                          |
| `product_number`       | NVARCHAR(50) | Structured alphanumeric code representing the product.               |
| `product_name`         | NVARCHAR(50) | Descriptive product name including type, color, or size.             |
| `category_id`          | NVARCHAR(50) | Identifier linking the product to a high-level category.             |
| `category`             | NVARCHAR(50) | Broader classification of the product (e.g., *Bikes*, *Components*). |
| `subcategory`          | NVARCHAR(50) | Detailed classification of the product within its category.          |
| `maintenance_required` | NVARCHAR(50) | Indicates if the product requires maintenance (*Yes*/*No*).          |
| `cost`                 | INT          | Base price or cost of the product.                                   |
| `product_line`         | NVARCHAR(50) | Product line or series (e.g., *Road*, *Mountain*).                   |
| `start_date`           | DATE         | Date when the product became available for sale.                     |

---

### **3. gold.fact\_sales**

**Purpose:** Contains transactional sales data, capturing measures and relationships to dimensions for analysis.

**Columns:**

| Column Name     | Data Type    | Description                                                            |
| --------------- | ------------ | ---------------------------------------------------------------------- |
| `order_number`  | NVARCHAR(50) | Unique alphanumeric identifier for each sales order (e.g., *SO54496*). |
| `product_key`   | INT          | Surrogate key linking to **gold.dim\_products**.                       |
| `customer_key`  | INT          | Surrogate key linking to **gold.dim\_customers**.                      |
| `order_date`    | DATE         | Date when the order was placed.                                        |
| `shipping_date` | DATE         | Date when the order was shipped to the customer.                       |
| `due_date`      | DATE         | Date when payment for the order was due.                               |
| `sales_amount`  | INT          | Total sales amount for the line item, in whole currency units.         |
| `quantity`      | INT          | Number of product units ordered.                                       |
| `price`         | INT          | Price per unit of product for the line item.                           |

---
