import mysql.connector
from mysql.connector import Error

def create_database():
    try:
        # Establish a connection to the MySQL server
        mydb = mysql.connector.connect(
            host="localhost",  # Replace with your host
            user="yourusername",  # Replace with your MySQL username
            password="yourpassword"  # Replace with your MySQL password
        )

        if mydb.is_connected():
            # Create a cursor to execute SQL statements
            mycursor = mydb.cursor()

            # Create the database if it doesn't exist
            mycursor.execute("CREATE DATABASE IF NOT EXISTS alx_book_store")
            print("Database 'alx_book_store' created successfully!")

    except Error as e:
        # Print an error message if there is a connection or SQL error
        print(f"Error connecting to MySQL or creating database: {e}")

    finally:
        # Ensure that the connection is closed
        if mydb.is_connected():
            mycursor.close()
            mydb.close()
            print("MySQL connection closed.")

if __name__ == "__main__":
    create_database()
