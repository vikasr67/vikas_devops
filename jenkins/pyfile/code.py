# python_script.py

# Step 1: Ask for the user's name
name = input("What is your name? ")

# Step 2: Greet the user
print(f"Hello, {name}!")

# Step 3: Ask for the user's birth year
birth_year = int(input("What year were you born? "))

# Step 4: Get the current year
from datetime import datetime
current_year = datetime.now().year

# Step 5: Calculate the user's age
age = current_year - birth_year

# Step 6: Display the user's age
print(f"You are {age} years old.")

# Step 7: Ask if they like Python
like_python = input("Do you like Python? (yes/no): ")

# Step 8: Respond based on their answer
if like_python.lower() == "yes":
    print("That's awesome!")
else:
    print("Oh no, maybe you'll like it more later!")

# Step 9: Thank the user
print("Thanks for chatting with me!")

# Step 10: Goodbye message
print("Goodbye!")

