User_info = [

    {
        "name": "vikas",
        "company": "Walmart"
    },

    {
        "name": "Deepu",
        "company": "Huron"
    },

    {
        "name": "Hemu",
        "company": "E3 woods"
    }

]

## to print all the name
for user in User_info:
    
    print("name of user is", user["name"], user["company"])


###to print specific user, like in second list element
print("-" * 20)
print(User_info[1]["name"], "works in", User_info[1]["company"])




