import mysql.connector
import sys

-- Ensure a database name is provided as a command-line argument
if len(sys.argv) != 2:
    print("Usage: python task_5.py <database_name>")
    sys.exit(1)

database_name = sys.argv[1]

-- Database connection details 
mydb = mysql.connector.connect(
    host="localhost",
    user="yourusername",  -- Replace with your MySQL username
    password="yourpassword"  -- Replace with your MySQL password
)

mycursor = mydb.cursor()

-- Insert a single row into the Customers table
try:
    -- Use the specified database
    mycursor.execute(f"USE {database_name};")
    print(f"Switched to database '{database_name}'.")

    -- Insert the customer data
    sql = """
    INSERT INTO Customers (customer_id, customer_name, email, address)
    VALUES (%s, %s, %s, %s);
    """
    val = (1, 'Cole Baidoo', 'cbaidoo@sandtech.com', '123 Happiness Ave.')
    mycursor.execute(sql, val)
    mydb.commit()

    print(mycursor.rowcount, "record inserted.")

except mysql.connector.Error as err:
    print(f"Error: {err}")

finally:
    -- Close the cursor and database connection
    if mycursor:
        mycursor.close()
    if mydb:
        mydb.close()
    print("Database connection closed.")

