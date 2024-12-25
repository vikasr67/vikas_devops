# code.py

# Step 1: Set default values for testing purposes
name = "vikas"  # You can change this to whatever name you want to test with
birth_year = 1997  # Change this as needed

# Step 2: Greet the user
print(f"Hello, {name}!")

# Step 3: Get the current year
from datetime import datetime
current_year = datetime.now().year

# Step 4: Calculate the user's age
age = current_year - birth_year

# Step 5: Display the user's age
print(f"You are {age} years old.")

# Step 6: Assume they like Python for testing purposes
like_python = "yes"  # You can set this to "no" to simulate the opposite case

# Step 7: Respond based on their answer
if like_python.lower() == "yes":
    print("That's awesome!")
else:
    print("Oh no, maybe you'll like it more later!")

# Step 8: Thank the user
print("Thanks for chatting with me!")

# Step 9: Goodbye message
print("Goodbye!")

