import os

##to collect the input from users##

NameOfFolders = input("Please provide the folder name to list the files: ").split()


for folders in NameOfFolders:
    

    try:
        files = os.listdir(folders)
    except FileNotFoundError:
        print("======Please provide the valid folder name", folders)
        continue

    

    print("======Name of the folder is",folders,". Below are the files inside it")

    for i in files:
        print(i)






