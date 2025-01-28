import requests

pulls =  requests.get("http://api.github.com/repos/kubernetes/kubernetes/pulls")  ### request.get is nothing but paste this url in browser

print(pulls)  ## this will pull status code only

# print(pulls.json())   ## this will print all the data in the disctiory 

data = pulls.json()

print(data[1]["id"]) ### to print first user pull id only

## lets try to pull all all pull requests user Id

for i in data:
    print(i["user"]["login"])