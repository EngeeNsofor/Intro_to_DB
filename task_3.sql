import mysql.connector
import sys

--  Ensure a database name is provided as a command-line argument
if len(sys.argv) != 2:
    print("Usage: python task_3.py <database_name>")
    sys.exit(1)

database_name = sys.argv[1]

-- Database connection details 
mydb = mysql.connector.connect(
    host="localhost",
    user="yourusername",  # Replace with your MySQL username
    password="yourpassword"  # Replace with your MySQL password
)

mycursor = mydb.cursor()

-- Create the database if it doesn't exist
try:
    mycursor.execute(f"CREATE DATABASE IF NOT EXISTS {database_name}")
    print(f"Database '{database_name}' created successfully (if it didn't already exist).")

    -- Connect to the specified database
    mydb.database = database_name

    -- Query to list all tables in the database
    mycursor.execute("SHOW TABLES")
    tables = mycursor.fetchall()

    if tables:
        print(f"Tables in '{database_name}':")
        for table in tables:
            print(table[0])
    else:
        print(f"No tables found in '{database_name}'.")

except mysql.connector.Error as err:
    print(f"Error: {err}")
finally:
    -- Close the cursor and database connection
    if mycursor:
        mycursor.close()
    if mydb:
        mydb.close()
    print("Database connection closed.")
