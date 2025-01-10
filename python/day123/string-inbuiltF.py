ARN = "arn:aws:sns:us-east-1:123456789012:example-sns-topic-name"

print(ARN.split(":")[3])

##print is used to print the outpunt
#ARN.Split, ARN is string that you specified in first line and split is inbuilt function where it is splitting by : 
#[3] is to print the third split


name= "vikas rajshekar"

print(name.upper())

# to print in upper case 

name2= "VIKAS FROM AJJAMPURa"

print(name2.lower())


#concatination --> adding 2 different strings
value1= "vikas working in"
value2= "walmart!!"
#now value 1 and 2 are strings
value3= value1 + " " + value2

print(value3)



## to print length od the line using len() inbuilt functions
text="i like to drive lamborghini"

length= len(text)

print(text)
print("The length of the above line is", length)

## to replace with other text

line="  I am excited to learn Python  "
line2= (line.replace("excited" , "thrilled"))

print (line2)


#using above line to stripped --> to ignore spaces

line3=(line.strip())
print =(line3)




##using substring 

ntext=("Vikas is Good in learning")
substring="is"
if substring in ntext:
    print(substring , "found in text") 



