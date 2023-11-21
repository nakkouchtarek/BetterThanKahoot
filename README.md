# TriviaGame

This is a custom version of Kahoot, written from scratch with vanilla Javascript.
<br/>
This project uses a lot of technologies : <br/>
* FastAPI
* WebSockets and Python sockets
* HTML, CSS and JS
* Python Bluetooth
<br/>

The project could have been done using prebuilt technologies, but I wanted to test what I can make using the most basic of tools.<br/>
Where user would launch all the scripts, then through a shell or phone connected with bluetooth could control the flow of the application,
whether to go to next question, show results, start timer...

# How to setup

Setup will be shown for Linux systems but the same could be done for Windows aswell.<br/>

Install XAMPP for easiest use, or setup MySQL and apache on your own.<br/>
Also make sure you have python and pip installed.<br/>

If you're having external managed environement problem, you could make a virtual environement to run this from :<br/>

https://www.freecodecamp.org/news/how-to-setup-virtual-environments-in-python/<br/><br/>

Or just use the virtual environement folder I have set up with all the packages needed, except for pybluez. <br/>

There are 2 socket programs, one with bluetooth and the other based on keyboard input through a terminal, <br/>
if you want to use bluetooth, install python package pybluez and change the socket.sh script to server_full.py instead of server_test.py<br/>

Create a database called `quiz` and import the quiz.sql in ./databases/quiz.sql<br/>

Change the variable domain to your domain name / IP in script.js of each of the game and spectator folders<br/>
Copy the /game and /spectator folders to htdocs folder in xampp or your apache folder.

```
sudo cp -r ./{game,spectator} /opt/lampp/htdocs/
```

Give execution permission to scripts

```
chmod +x ./Linux/*
```

Install python packages that are needed

```
./Linux/./setup.sh
```

If you don't want to install the packages or want to use a virtual env, you can just enable the one I put in directly and proceed

```
source ./env/bin/activate
```

Each of the API and Socket scripts will require a terminal of their own

Start API

```
./Linux/./api.sh $IP
```

Start socket

```
./Linux/./socket.sh $IP
```

The spectator page is meant to be for a display screen for spectators, <br/>
So when it's on, go to full screen, and zoom in/out depending on your screen size to match it.<br/>


# Spectator mode

https://github.com/nakkouchtarek/TriviaGame/assets/98561646/c5e3c007-b609-4e3e-aa9a-c07bd5fd6187

# User mode

https://github.com/nakkouchtarek/TriviaGame/assets/98561646/5e9bf4c9-dbe8-472a-bf2b-079292c68c90



