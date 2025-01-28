import requests

vikas = requests.get("https://api.github.com/users/vikasr67/repos")


repos = vikas.json()




for list in repos:
    print(list["full_name"])