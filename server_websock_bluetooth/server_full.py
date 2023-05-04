import websockets, threading, asyncio
from queue import Queue
import random, sys, requests, os, json, time
import bluetooth
from subprocess import call

q = Queue()

CLIENTS = set()
WORD = ''
count = 0
ready=False
sent=False
answered=True
index = 0
question_per_round = 1
final_q = 1
GROUPS = ["a","b","c","d"]
domain=sys.argv[1]
limit = int(str(json.loads(requests.get(f"http://{domain}:8000/api/getRows").text)["number"])[1:-1])
questions = []

basic = {
    "command":"",
    "question":""
}


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


def add_question(r):
    global q
    global questions

    i = 0

    while i<r:
        elem = str(random.randint(1,limit))

        if elem not in questions:
            print(f"Added question {elem}")
            q.put(elem)
            questions.append(elem)
            i+=1

def start_timer():
    requests.get(f"http://{domain}:8000/api/startTimer")
    print("FInished timwer")

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

    server_sock = bluetooth.BluetoothSocket(bluetooth.RFCOMM)

    server_sock.bind(("", bluetooth.PORT_ANY))
    server_sock.listen(1)

    port = server_sock.getsockname()[1]

    uuid = "94f39d29-7d6d-437d-973b-fba39e49d4ee"
    
    call(['sudo','hciconfig','hci0','piscan']) 

    bluetooth.advertise_service(server_sock, "SampleServer", service_id=uuid,
                                service_classes=[uuid, bluetooth.SERIAL_PORT_CLASS],
                                profiles=[bluetooth.SERIAL_PORT_PROFILE],
                                )

    print("Waiting for connection on RFCOMM channel", port)

    conn, addr = server_sock.accept()
    
    print("Accepted")


    while True:

        try:
            c = conn.recv(1024).decode()
        except:
            print("Error occured in admin connection!")
            conn.close()
            server_sock.close()
            exit(-1)

        if c == "0" and not ready:

            if index >= len(GROUPS):
                reset()

                basic["command"] = "ready"
                basic["group"] = GROUPS[index]
                WORD=str(basic)

                print(f"Current Group: {GROUPS[index]}")

                if GROUPS[index] == "d":
                    add_question(final_q)
                else:
                    add_question(question_per_round)

                ready=True
                answered=True

            else:
                basic["command"] = "ready"
                basic["group"] = GROUPS[index]
                WORD=str(basic)

                print(f"Current Group: {GROUPS[index]}")

                add_question(question_per_round)

                ready=True

        elif c == "4":
            reset()

            basic["command"] = "reset"
            basic["count"] = len(CLIENTS)
            WORD=str(basic)

        else:
            if ready:
                if c == "1" and answered:
                    if not q.empty():

                        basic["command"] = "go"
                        basic["question"] = str(q.get())
                        basic["group"] = GROUPS[index]
                        WORD=str(basic)

                        print(f"Sent question to group {GROUPS[index]}")
                        sent=True
                        answered=False

                    else:
                        try:

                            w = list(json.loads(requests.get(f"http://{domain}:8000/api/getWinner?group={GROUPS[index]}").text)["winners"])

                            #print(f"{w} : {len(w)}")
                            
                            if (len(w) > 30 and GROUPS[index] == "a") or (len(w) > 15 and GROUPS[index] == "b") or (len(w) > 5 and GROUPS[index] == "c") or (len(w) > 1 and GROUPS[index] == "d"):
                                print("More questions!!")
                                add_question(1)

                                if GROUPS[index] == "d":
                                    basic["command"] = "final"
                                else:
                                    basic["command"] = "win"

                                WORD = str(basic)

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

                        except:

                            print("Empty group")
                            ready=False
                            index += 1

                elif c == "2":
                    
                    basic["command"] = "board"
                    WORD=str(basic)


                elif c == "5" and not answered:

                    if not sent:
                        print("Question not sent!")
                    else:
                        basic["command"] = "start"
                        basic["group"] = GROUPS[index]
                        WORD=str(basic)

                        time.sleep(1)
                        threading.Thread(target=start_timer).start()
                        sent=False
                        answered=True

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
