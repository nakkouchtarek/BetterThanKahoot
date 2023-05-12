import mysql.connector

form = """
"test23":{"id":"63","name":"test16","last":"tester6","score":0,"counter":10,"answered":8,"code":"111111","group":"a"}
"""

mydb = mysql.connector.connect(host="localhost",user="root",password="")

mycursor = mydb.cursor()

mycursor.execute("USE quiz;")

mycursor.execute(f"SELECT first, last FROM players;")
res = mycursor.fetchall()

counter=1

for first, last in res:
    print(f"""\"test{counter}\":""", end="")
    print("{",end="")
    print("""\"id\":\"{c1}\",\"name\":\"{first}\",\"last\":\"{last}\",\"score\":{score},\"counter\":10,\"answered\":8,\"code\":\"111111\",\"group\":\"a\"""".format(c1=counter,first=first.split(" ")[0],last=last.split(" ")[0],score=counter*10),end="")
    print("},")
    counter+=1