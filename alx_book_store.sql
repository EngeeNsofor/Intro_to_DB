import mysql.connector

-- Database connection details 
mydb = mysql.connector.connect(
    host="localhost",
    user="yourusername",  -- Replace with your MySQL username
    password="yourpassword",  -- Replace with your MySQL password
    database="alx_book_store"  -- Ensure the database exists or replace with your target db
)

mycursor = mydb.cursor()


-- Create the database if it doesn't exist
mycursor.execute("CREATE DATABASE IF NOT EXISTS alx_book_store")
print("Database 'alx_book_store' created successfully (if it didn't already exist).")

# Connect to the 'alx_book_store' database
mydb.database = "alx_book_store"


-- Create the Authors table
mycursor.execute("""
CREATE TABLE IF NOT EXISTS Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(215) NOT NULL
)
""")
print("Authors table created successfully!")


-- Create the Books table
mycursor.execute("""
CREATE TABLE IF NOT EXISTS Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(130) NOT NULL,
    author_id INT,
    price DOUBLE NOT NULL,
    publication_date DATE,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE SET NULL ON UPDATE CASCADE
)
""")
print("Books table created successfully!")


-- Create the Customers table
mycursor.execute("""
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(215) NOT NULL,
    email VARCHAR(215) NOT NULL UNIQUE,
    address TEXT
)
""")
print("Customers table created successfully!")


-- Create the Orders table
mycursor.execute("""
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE ON UPDATE CASCADE
)
""")
print("Orders table created successfully!")


-- Create the Order_Details table
mycursor.execute("""
CREATE TABLE IF NOT EXISTS Order_Details (
    orderdetailid INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity DOUBLE NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE ON UPDATE CASCADE
)
""")
print("Order_Details table created successfully!")


-- Insert data into Authors table
sql = "INSERT INTO Authors (author_name) VALUES (%s)"
val = ("George Orwell",)
mycursor.execute(sql, val)
mydb.commit()
print(mycursor.rowcount, "author record inserted.")

val = ("Jane Austen",)
mycursor.execute(sql, val)
mydb.commit()
print(mycursor.rowcount, "author record inserted.")


-- Insert data into Books table
sql = "INSERT INTO Books (title, author_id, price, publication_date) VALUES (%s, %s, %s, %s)"
val = ("1984", 1, 19.99, "1949-06-08")
mycursor.execute(sql, val)
mydb.commit()
print(mycursor.rowcount, "book record inserted.")

val = ("Pride and Prejudice", 2, 9.99, "1813-01-28")
mycursor.execute(sql, val)
mydb.commit()
print(mycursor.rowcount, "book record inserted.")


-- Insert data into Customers table
sql = "INSERT INTO Customers (customer_name, email, address) VALUES (%s, %s, %s)"
val = ("John Doe", "john.doe@example.com", "123 Main St")
mycursor.execute(sql, val)
mydb.commit()
print(mycursor.rowcount, "customer record inserted.")

val = ("Jane Smith", "jane.smith@example.com", "456 Oak St")
mycursor.execute(sql, val)
mydb.commit()
print(mycursor.rowcount, "customer record inserted.")


-- Read all customer data
mycursor.execute("SELECT * FROM Customers")
myresult = mycursor.fetchall()

print("Customers:")
for row in myresult:
    print(row)


-- Update a customer's email
sql = "UPDATE Customers SET email = %s WHERE customer_id = %s"
val = ("updated.email@example.com", 1)
mycursor.execute(sql, val)
mydb.commit()
print(mycursor.rowcount, "record(s) updated.")


-- Read the updated customer data
mycursor.execute("SELECT * FROM Customers WHERE customer_id = 1")
myresult = mycursor.fetchone()

print("Updated customer:")
print(myresult)


-- Delete a customer
sql = "DELETE FROM Customers WHERE customer_id = 2"
mycursor.execute(sql)
mydb.commit()
print(mycursor.rowcount, "record(s) deleted.")


-- Close connections
mycursor.close()
mydb.close()
print("Database connection closed.")