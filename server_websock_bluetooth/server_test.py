import websockets, threading, asyncio
from queue import Queue
import random, sys, requests, os, json, time
import mysql.connector

q = Queue()

CLIENTS = set()
WORD = ''
count = 0
ready=False
sent=False
answered=True
index = 0
question_per_round = 10
GROUPS = ["a","b","c","d"]
domain=sys.argv[1]
questions = []
db = "questions"
next = "0"

mydb = mysql.connector.connect(host="localhost",user="root",password="")

mycursor = mydb.cursor()

mycursor.execute("USE quiz;")

mycursor.execute(f"SELECT COUNT(*) FROM {db};")
limit = int(mycursor.fetchone()[0])

basic = {
    "command":"",
    "question":""
}

def add_question(r):
    global q
    global questions
    l=[]
    i = 0

    mycursor.execute(f"SELECT id FROM {db} WHERE category = '{GROUPS[index]}';")

    for elem in mycursor.fetchall():
        l.append(str(elem[0]))

    #print("Questions in db: "+str(l))

    while i<r:
        elem = str(random.choice(l))

        if elem not in questions:
            q.put(elem)
            questions.append(elem)
            i+=1

    print("Questions in queue: ", end="")
    print(list(q.queue))
    #print("Already done: ", end="")
    #print(questions)


def reset():
    global WORD
    global basic
    global count
    global CLIENTS
    global ready
    global sent
    global index
    global question_per_round
    global GROUPS
    global q
    global questions
    global answered

    requests.get(f"http://{domain}:8000/api/getReset")
                    
    ready=False
    sent=False
    answered=True
    count=0
    basic["command"] = "close"
    WORD=str(basic)
    basic = {
        "command":"",
        "question":""
    }
    index=0
    with q.mutex: q.queue.clear()
    questions.clear()


def start_timer():
    global sent
    global answered
    print("Start timer")
    requests.get(f"http://{domain}:8000/api/startTimer")
    print("\nFinished timer")
    sent=False
    answered=True

def input_loop():
    global WORD
    global basic
    global count
    global CLIENTS
    global ready
    global sent
    global index
    global question_per_round
    global GROUPS
    global answered
    global next

    while True:
        time.sleep(5)
        print("*: Next\n2:Show board")
        c=input(">> ")

        if index == 4:
            index = 0

        if c == "2":

            basic["command"] = "board"
            WORD=str(basic)

        elif next == "0" and not ready:

                basic["command"] = "ready"
                basic["group"] = GROUPS[index]
                WORD=str(basic)

                print(f"Current Group: {GROUPS[index]}")

                add_question(question_per_round)

                ready=True
                answered=True
                next = "1"

        else:
            if ready:
                if next == "1" and answered:
                    if not q.empty():

                        basic["command"] = "go"
                        basic["question"] = str(q.get())
                        basic["group"] = GROUPS[index]
                        WORD=str(basic)

                        print(f"Sent question to group {GROUPS[index]}")
                        sent=True
                        answered=False
                        next = "5"
                    else:
                        try:

                            w = list(json.loads(requests.get(f"http://{domain}:8000/api/getWinner?group={GROUPS[index]}").text)["winners"])

                            #print(f"{w} : {len(w)}")
                            
                            if (len(w) > 30 and GROUPS[index] == "a") or (len(w) > 15 and GROUPS[index] == "b") or (len(w) > 5 and GROUPS[index] == "c") or (len(w) > 1 and GROUPS[index] == "d"):
                                print("More questions!!")
                                add_question(1)

                                basic["command"] = "equal"
                                WORD = str(basic)
                                ready=True
                                next = "1"

                            else:

                                print(f"Queue is empty and we can move to next round!")

                                if GROUPS[index] == "d":
                                    basic["command"] = "final"
                                else:
                                    basic["command"] = "win"

                                basic["group"] = GROUPS[index]
                                WORD=str(basic)

                                ready=False
                                index += 1
                                next = "0"

                        except:

                            print("Empty group")
                            ready=False
                            index += 1
                            next = "0"


                elif next == "5" and not answered:

                    if not sent:
                        print("Question not sent!")
                    else:
                        basic["command"] = "start"
                        basic["group"] = GROUPS[index]
                        WORD=str(basic)

                        time.sleep(1)
                        threading.Thread(target=start_timer).start()
                        next = "1"

                else:
                    print("Not ready!")

                    
async def broadcast(message):
    global WORD
    global basic

    for websocket in CLIENTS.copy():
        try:
            await websocket.send(message)
        except websockets.ConnectionClosed:
            CLIENTS.remove(websocket)

            basic["command"] = "new"
            basic["count"] = len(CLIENTS)

            WORD=str(basic)

            await broadcast(WORD)
        
    WORD=''

async def handler(websocket):
    global WORD
    global count

    CLIENTS.add(websocket)

    basic["command"] = "new"
    basic["count"] = len(CLIENTS)

    WORD=str(basic)

    try:
        await websocket.wait_closed()
    except:
        CLIENTS.remove(websocket)

        basic["command"] = "new"
        basic["count"] = len(CLIENTS)

        WORD=str(basic)

async def full():
    while True:
        await asyncio.sleep(1)
        await broadcast(WORD)

async def main():
    async with websockets.serve(handler, domain, 5555):
        await full()

if __name__ == "__main__":
    threading.Thread(target=input_loop).start()
    asyncio.run(main())
