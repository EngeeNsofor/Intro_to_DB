import mysql.connector
import sys

-- Ensure a database name is provided as a command-line argument
if len(sys.argv) != 2:
    print("Usage: python task_6.py <database_name>")
    sys.exit(1)

database_name = sys.argv[1]

-- Database connection details 
mydb = mysql.connector.connect(
    host="localhost",
    user="yourusername",  -- Replace with your MySQL username
    password="yourpassword"  -- Replace with your MySQL password
)

mycursor = mydb.cursor()

-- Insert multiple rows into the Customers table
try:
    -- Use the specified database
    mycursor.execute(f"USE {database_name};")
    print(f"Switched to database '{database_name}'.")

    -- Insert multiple customer data
    sql = """
    INSERT INTO customer (customer_id, customer_name, email, address)
    VALUES (%s, %s, %s, %s);
    """
    customers_data = [
        (2, 'Blessing Malik', 'bmalik@sandtech.com', '124 Happiness Ave.'),
        (3, 'Obed Ehoneah', 'eobed@sandtech.com', '125 Happiness Ave.'),
        (4, 'Nehemial Kamolu', 'nkamolu@sandtech.com', '126 Happiness Ave.')
    ]
    
    mycursor.executemany(sql, customers_data)
    mydb.commit()

    print(mycursor.rowcount, "records inserted.")

except mysql.connector.Error as err:
    print(f"Error: {err}")

finally:
    -- Close the cursor and database connection
    if mycursor:
        mycursor.close()
    if mydb:
        mydb.close()
    print("Database connection closed.")
