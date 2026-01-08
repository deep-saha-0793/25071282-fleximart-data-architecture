#!/usr/bin/env python
# coding: utf-8

# In[4]:


# STEP 2: Import required libraries

import pandas as pd
import mysql.connector
from dateutil import parser
import re

print("Libraries imported successfully")


# In[1]:


get_ipython().system('pip install --upgrade mysql-connector-python')


# In[1]:


import sys
print(sys.executable)


# In[4]:


import pymysql

try:
    conn = pymysql.connect(
        host="localhost",
        user="root",
        password="root123"
    )
    cursor = conn.cursor()
    print("Connected to MySQL from Jupyter successfully")
except pymysql.MySQLError as err:
    print("Error:", err)


# In[6]:


# Create database if not exists
cursor.execute("CREATE DATABASE IF NOT EXISTS fleximart;")
cursor.execute("USE fleximart;")

# Create tables as per provided schema
cursor.execute("""
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    city VARCHAR(50),
    registration_date DATE
);
""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0
);
""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
""")

print("Database and tables created successfully")


# In[7]:


import pandas as pd

# Load CSV files
customers_df = pd.read_csv("customers_raw.csv")
products_df = pd.read_csv("products_raw.csv")
sales_df = pd.read_csv("sales_raw.csv")  # Correct file name

# Check first few rows
display(customers_df.head())
display(products_df.head())
display(sales_df.head())


# In[8]:


import pandas as pd
import re

# Strip column names to remove extra spaces
customers_df.columns = customers_df.columns.str.strip()

# Remove duplicates
customers_df = customers_df.drop_duplicates()

# Fill missing emails
customers_df['email'] = customers_df['email'].fillna("unknown@example.com")

# Standardize phone numbers
def clean_phone(phone):
    if pd.isna(phone):
        return None
    digits = re.sub(r'\D', '', str(phone))
    if len(digits) >= 10:
        return "+91-" + digits[-10:]
    else:
        return None

customers_df['phone'] = customers_df['phone'].apply(clean_phone)

# Convert registration_date to YYYY-MM-DD
customers_df['registration_date'] = pd.to_datetime(customers_df['registration_date'], errors='coerce').dt.strftime('%Y-%m-%d')

# Display cleaned DataFrame
display(customers_df.head())


# In[2]:


# Strip column names to remove extra spaces
sales_df.columns = sales_df.columns.str.strip()

# Remove duplicates
sales_df.drop_duplicates(inplace=True)

# Drop rows missing customer_id or product_id
sales_df.dropna(subset=['customer_id', 'product_id'], inplace=True)

# Convert transaction_date to YYYY-MM-DD
sales_df['transaction_date'] = pd.to_datetime(sales_df['transaction_date'], errors='coerce').dt.strftime('%Y-%m-%d')

# Calculate subtotal if not present
if 'subtotal' not in sales_df.columns:
    sales_df['subtotal'] = sales_df['quantity'] * sales_df['unit_price']

# Display first few cleaned rows
display(sales_df.head())


# In[10]:


# Final NaN safety check before DB insert
products_df['price'] = products_df['price'].fillna(products_df['price'].mean())
products_df['stock_quantity'] = products_df['stock_quantity'].fillna(0)
products_df['category'] = products_df['category'].fillna('Unknown')
products_df['product_name'] = products_df['product_name'].fillna('Unknown Product')

# Replace any remaining NaN with None (MySQL-compatible)
products_df = products_df.where(pd.notnull(products_df), None)


product_id_map = {}

for _, row in products_df.iterrows():
    cursor.execute("""
        INSERT INTO products (product_name, category, price, stock_quantity)
        VALUES (%s, %s, %s, %s)
    """, (
        row['product_name'],
        row['category'],
        float(row['price']),
        int(row['stock_quantity'])
    ))

    product_id_map[row['product_id']] = cursor.lastrowid

conn.commit()
print("Products loaded successfully")


# In[11]:


print(products_df.isna().sum())


# In[14]:


# Fix missing emails with unique values
customers_df['email'] = customers_df.apply(
    lambda row: row['email']
    if pd.notna(row['email'])
    else f"unknown_{row.name}@example.com",
    axis=1
)

customers_df = customers_df.where(pd.notnull(customers_df), None)



# In[15]:


customer_id_map = {}

for _, row in customers_df.iterrows():
    try:
        cursor.execute("""
            INSERT INTO customers (first_name, last_name, email, phone, city, registration_date)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (
            row['first_name'],
            row['last_name'],
            row['email'],
            row['phone'],
            row['city'],
            row['registration_date']
        ))
        customer_id_map[row['customer_id']] = cursor.lastrowid
    except pymysql.err.IntegrityError:
        pass

conn.commit()
print("Customers loaded successfully")


# In[16]:


print(customers_df['email'].isna().sum())
print(customers_df['email'].nunique())


# In[17]:


print(len(customer_id_map), len(product_id_map))


# In[23]:


# Standardize transaction_date (CRITICAL)
sales_df['transaction_date'] = pd.to_datetime(
    sales_df['transaction_date'],
    errors='coerce',
    dayfirst=True
).dt.strftime('%Y-%m-%d')

# Drop invalid rows
sales_df = sales_df.dropna(subset=['transaction_date', 'customer_id'])

# MySQL-safe NULL handling
sales_df = sales_df.where(pd.notnull(sales_df), None)


# In[24]:


orders_inserted = 0

for _, row in sales_df.iterrows():
    db_customer_id = customer_id_map.get(row['customer_id'])

    if db_customer_id is None:
        continue

    total_amount = float(row['quantity']) * float(row['unit_price'])

    cursor.execute("""
        INSERT INTO orders (customer_id, order_date, total_amount, status)
        VALUES (%s, %s, %s, %s)
    """, (
        db_customer_id,
        row['transaction_date'],
        total_amount,
        row['status']
    ))

    orders_inserted += 1

conn.commit()
print(f"Orders loaded successfully: {orders_inserted}")


# In[ ]:





# In[ ]:




