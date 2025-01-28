import sys

def add(x, y):
    return x + y
    

def sub(x, y):
    return x - y
    

def mul(x, y):
    return x * y
    

def div(x, y):
    return x / y
   


x= int(sys.argv[1])
y= int(sys.argv[2])
operation= sys.argv[3]

if operation == "add":
    output= add(x,y)
    print("The value is", output)
elif operation == "sub":
    output= sub(x, y)
    print("The value is", output)

elif operation == "mul":
    output= mul(x,y)
    print("The value is", output)

elif operation == "div":
    output= div(x, y)
    print("The value is", output)

else:
    print("Please use the valid operator")



