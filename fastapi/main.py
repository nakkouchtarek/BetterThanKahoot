from fastapi import FastAPI, Response, Request
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
import json
import random
import uuid
import pandas as pd
import xlsxwriter
import mysql.connector
import time
import asyncio
import string

alphabet = list(string.ascii_uppercase)
valid = ["0","1","2","3","4","5","6","7","8","9"]
db = "questions"

def sanitize_id(word):
    s = ""

    for elem in word:
        if elem in valid:
            s += elem

    return s

def sanitize_code(word):
    s = ""

    for elem in word.upper():
        if elem in alphabet or elem in valid:
            s += elem

    return s

mydb = mysql.connector.connect(host="localhost",user="root",password="")

mycursor = mydb.cursor()

mycursor.execute("USE quiz;")

def get_question(id):
    mycursor.execute(f"SELECT * FROM {db} WHERE id = {sanitize_id(id)};")
    print(id)
    res = mycursor.fetchone()
    j = {"content":res[1],"a":res[2],"b":res[3],"c":res[4],"d":res[5]}
    return j

def get_all_questions():
    mycursor.execute(f"SELECT * FROM {db};")
    return mycursor.fetchall()

def insert_question(content,a,b,c,d,answer):
    mycursor.execute(f"INSERT INTO `{db}`(`content`, `a`, `b`, `c`, `d`, `answer`) VALUES ('{str(content)}','{str(a)}','{str(b)}','{str(c)}','{str(d)}','{str(answer)}')")

rates = {
    "a": 0,
    "b": 0,
    "c": 0,
    "d": 0
}

n_per_group = 100

groups = {
    "a" : n_per_group,
    "b" : 0,
    "c" : 0
}

g2 = ["a","b","c","d","f"]

ids = {}

codes = []

id=1
stat=10

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

def get_group():
    global groups

    if groups["a"] == 0:
        return "n"
    else:
        groups["a"] -= 1
        return "a"


@app.get("/")
async def root():
    return {"message": "Hello"}

@app.get("/api/startTimer")
async def start_timer():
    global stat
    
    for i in range(10):
        stat-=1
        await asyncio.sleep(1)

    stat=10
    return {"success":"true"}

@app.get("/api/getRows")
async def get_rows():
    mycursor.execute(f"SELECT COUNT(*) FROM {db};")
    res = mycursor.fetchone()
    return {"number":res}

def fetch_user(code):
    mycursor.execute(f"SELECT first,last FROM players WHERE code LIKE '{code.upper()}';")
    res = mycursor.fetchone()
    return {"first":res[0],"last":res[1]}

@app.post("/api/register")
async def create_cookie(request: Request):
    global id
    j = await request.json()
    code = j["code"]
    l = fetch_user(code)

    cookie = str(uuid.uuid4())
    ids[cookie] = {"id":str(id),"name":l["first"].split(" ")[0],"last":l["last"].split(" ")[0],"score":0,"oldscore":0,"code":code,"group":get_group(),"counter":0,"answered":0}
    id+=1
    return {"cookie_name":"sessionID","value":f"{cookie}"}


@app.post("/api/getProfile")
async def send_test(request: Request):
    j = await request.json()
    return {"id": ids[j["sessionID"]]["id"], "name": ids[j["sessionID"]]["name"],"last": ids[j["sessionID"]]["last"], "score": ids[j["sessionID"]]["score"], "group": ids[j["sessionID"]]["group"]}


@app.get("/api/getQuestion")
async def send_quest(id: str):
    global rates
    rates = {"a": 0,"b": 0,"c": 0,"d": 0}
    return get_question(id)


@app.get("/api/getRates")
async def get_rate():
    return rates

@app.get("/api/getReset")
def get_reset():
    global groups
    global ids
    global id
    global n_per_group

    groups = {"a":n_per_group,"b":0,"c":0,"d":0}
    ids={}
    codes.clear()
    id=1

    return {"success":"true"}

@app.get("/api/getUsers")
async def get_names():
    l = {}
    i = 0

    for elem in ids:
        name = ids[elem]["name"]
        last = ids[elem]["last"]
        group = ids[elem]["group"]
        l[f"{i}"] = {"name":name,"last":last,"group":group}
        i+=1

    return l


@app.get("/api/getLeaderboard")
async def get_rate(group: str):
    global ids

    l={}

    index = g2.index(group)
    index2 = index + 1

    for elem in ids:
        id = ids[elem]["id"]
        score = ids[elem]["oldscore"]
        name = ids[elem]["name"]
        last = ids[elem]["last"]
        group = ids[elem]["group"]
        counter = ids[elem]["counter"]
        answered = ids[elem]["answered"]

        if ids[elem]["group"] == "fl" or ids[elem]["group"] == "l":
            l[id] = {"name":name,"last":last,"score":score,"group":group,"counter":counter,"answered":answered}
        elif ids[elem]["group"] == g2[index] or ids[elem]["group"] == g2[index2]:
            l[id] = {"name":name,"last":last,"score":score,"group":group,"counter":counter,"answered":answered}

    return sorted(l.items(), key=lambda x: x[1]["score"], reverse=True)


@app.get("/api/getWinner")
async def get_winner(group: str):
    global ids

    winners={"winners":[]}

    if group == "a":
        wanted = 30
    elif group == "b":
        wanted = 15
    elif group == "c":
        wanted = 5
    elif group == "d":
        wanted = 1

    last_score = 0
    
    l={}

    for elem in ids.copy():
        if ids[elem]["group"] == "l":
            del ids[elem]
        elif ids[elem]["group"] == group:
            id = ids[elem]["id"]
            score = ids[elem]["score"]
            name = ids[elem]["name"]

            l[id] = {"name":name,"score":score}

    l = sorted(l.items(), key=lambda x: x[1]["score"], reverse=True)
    new = l
    next = []

    for i in range(len(new)):
                score = l[i][1]["score"]
                    
                if i+1 == wanted:
                    last_score = score
                elif i+1 > wanted and score != last_score:
                    
                    for key in list(ids):
                        if ids[key]["id"] == str(l[i][0]):
                            if ids[key]["group"] != "d":
                                ids[key]["group"] = "l"
                            else:
                                ids[key]["group"] = "fl"

                    next.append(l[i])

    for elem in next:
        l.remove(elem)

    for elem in list(l):
        winners["winners"].append(elem)
        
    if( group=="d" and len(list(l)) == 1):

        for elem in ids:
            for e in list(l):
                if ids[elem]["id"] == e[0]:
                    ids[elem]["group"] = "f"
                    ids[elem]["oldscore"] = ids[elem]["score"]
                    ids[elem]["score"] = 0

    elif( group=="c" and len(list(l)) <= 5):

        for elem in ids:
            for e in list(l):
                if ids[elem]["id"] == e[0]:
                    ids[elem]["group"] = "d"
                    ids[elem]["oldscore"] = ids[elem]["score"]
                    ids[elem]["score"] = 0

    elif( group=="b" and len(list(l)) <= 15):

        for elem in ids:
            for e in list(l):
                if ids[elem]["id"] == e[0]:
                    ids[elem]["group"] = "c"
                    ids[elem]["oldscore"] = ids[elem]["score"]
                    ids[elem]["score"] = 0

    elif( group=="a" and len(list(l)) <= 30):

        for elem in ids:
            for e in list(l):
                if ids[elem]["id"] == e[0]:
                    ids[elem]["group"] = "b"
                    ids[elem]["oldscore"] = ids[elem]["score"]
                    ids[elem]["score"] = 0
                
    
    return winners
    

@app.post("/api/submitAnswer")
async def send_answer(request: Request):
    global rates
    global stat
    
    j = await request.json()
    
    q = int(j["question"])
    mycursor.execute(f"SELECT answer FROM {db} WHERE id = {q};")

    if j["answer"] == mycursor.fetchone()[0]:
        if int(stat)!=10:
            ids[j["sessionID"]]["score"] += int(stat*100)-100
        else:
            ids[j["sessionID"]]["score"] += int(stat*100)
        
        ids[j["sessionID"]]["answered"] += 1
        ids[j["sessionID"]]["counter"] += stat

    if j["answer"] == "a":
        rates["a"] += 1
    elif j["answer"] == "b":
        rates["b"] += 1
    elif j["answer"] == "c":
        rates["c"] += 1
    elif j["answer"] == "d":
        rates["d"] += 1

    return {"success":"true"}

@app.get("/api/hxhx")
async def get_answer(code: str, question: str):
    if code == "b0657d3289bae5be59176613e794ae1bf696c7e2ee529058760fe0b17b0d448f":
        q = int(question)
        mycursor.execute(f"SELECT answer FROM {db} WHERE id = {q};")
        return {"answer":f"{str(mycursor.fetchone()[0])}"}

@app.post("/api/disconnect")
async def disconnect(request: Request):
    global rates
    global stat
    
    j = await request.json()

    for elem in ids.copy():
        if elem == j["sessionID"]:
            codes.remove(ids[elem]["code"])
            del ids[elem]

    return {"success":"true"}

@app.get("/api/checkName")
async def get_user(name: str):
    if len(name) > 12:
        return {"success":"false"}

    for key in ids:
        if ids[key]["name"] == name:
            return {"success":"false"}

    return {"success":"true"}

@app.get("/api/checkCode")
async def check_code(code: str):
    global codes

    mycursor.execute(f"SELECT first,last FROM players WHERE code LIKE '{sanitize_code(code)}';")
    res = mycursor.fetchone()

    if res and code not in codes:
        codes.append(code)
        return {"success":"true"}
    else:  
        return {"success":"true"}

@app.get("/api/getUser")
async def get_user(id: str):
    for key in ids:
        if ids[key]["id"] == id:
            return {"name":ids[key]["name"],"score":ids[key]["score"],"group":ids[key]["group"]}

    return {"name":""}
