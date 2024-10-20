import mysql.connector
import sys

-- Ensure a database name is provided as a command-line argument
if len(sys.argv) != 2:
    print("Usage: python task_4.py <database_name>")
    sys.exit(1)

database_name = sys.argv[1]

-- Database connection details 
mydb = mysql.connector.connect(
    host="localhost",
    user="yourusername",  -- Replace with your MySQL username
    password="yourpassword"  -- Replace with your MySQL password
)

mycursor = mydb.cursor()

-- Retrieve and print the full description of the Books table
try:
    mycursor.execute(f"USE {database_name};")
    print(f"Switched to database '{database_name}'.")

    -- Query to show columns in the Books table
    mycursor.execute("SHOW COLUMNS FROM Books;")
    columns = mycursor.fetchall()

    if columns:
        print(f"\nFull description of the 'Books' table in '{database_name}':")
        for column in columns:
            field = column[0]
            type = column[1]
            nullable = column[2]
            key = column[3]
            default = column[4]
            extra = column[5]
            print(f"Field: {field}, Type: {type}, Null: {nullable}, Key: {key}, Default: {default}, Extra: {extra}")
    else:
        print(f"No columns found in the 'Books' table.")

except mysql.connector.Error as err:
    print(f"Error: {err}")
finally:
    -- Close the cursor and database connection
    if mycursor:
        mycursor.close()
    if mydb:
        mydb.close()
    print("Database connection closed.")
