var domain='localhost';
const ws = new WebSocket(`ws://${domain}:5555`);
var keyword = "b0657d3289bae5be59176613e794ae1bf696c7e2ee529058760fe0b17b0d448f";

function sleep (time) {
    return new Promise((resolve) => setTimeout(resolve, time));
}

async function change_state()
{
    if(document.getElementById("main_input").value != '')
    {
        if(document.getElementById("message").style.opacity=="1")
        {
            document.getElementById("message").style.opacity = "0";
            await sleep(500);
        }
        
        document.getElementById("main").style.top = "120%";
        await sleep(500);
        document.getElementById("titles").style.opacity = "0";
        connect_all();
    }
    else
    {
        document.getElementById("alert").innerText = "You have to enter your name!";
        document.getElementById("message").style.opacity = "1";
    }
}

async function update_score(score_arg)
{
    document.getElementById("score").style.opacity = "0";
    await sleep(500);
    document.getElementById("score").innerText = `Score: ${score_arg}`;
    await sleep(500);
    document.getElementById("score").style.opacity = "1";
}

async function update_alert(message)
{
    document.getElementById("main_m2").style.opacity = "0";
    document.getElementById("message").style.opacity = "0";
    await sleep(500);
    document.getElementById("alert").innerText = `${message}`;
    await sleep(500);
    document.getElementById("message").style.opacity = "1";
}

async function update_m2(message)
{
    document.getElementById("timer").style.opacity = "0";
    document.getElementById("message").style.opacity = "0";
    document.getElementById("buttons").style.opacity = "0";
    document.getElementById("main_m2").style.opacity = "0";

    await sleep(500);
    document.getElementById("main_m2").innerText = `${message}`;
    await sleep(500);
    document.getElementById("main_message").style.opacity = "1";
    document.getElementById("main_m2").style.opacity = "1";
}

async function spawn_buttons(a,b,c,d)
{
    document.getElementById(`group`).style.opacity = "0";

    document.getElementById("a").style.opacity = "0";
    document.getElementById("b").style.opacity = "0";
    document.getElementById("c").style.opacity = "0";
    document.getElementById("d").style.opacity = "0";

    document.getElementById("a").innerText = `${a}`;
    document.getElementById("b").innerText = `${b}`;
    document.getElementById("c").innerText = `${c}`;
    document.getElementById("d").innerText = `${d}`;

    document.getElementById("rate_a").innerHTML = ``;
    document.getElementById("rate_b").innerHTML = ``;
    document.getElementById("rate_c").innerHTML = ``;
    document.getElementById("rate_d").innerHTML = ``;

    document.getElementById("rate_a").innerHTML = `<h1>${a}</h1>`;
    document.getElementById("rate_b").innerHTML = `<h1>${b}</h1>`;
    document.getElementById("rate_c").innerHTML = `<h1>${c}</h1>`;
    document.getElementById("rate_d").innerHTML = `<h1>${d}</h1>`;

    document.getElementById(`rate_a`).style.boxShadow = `none`;
    document.getElementById(`rate_b`).style.boxShadow = `none`;
    document.getElementById(`rate_c`).style.boxShadow = `none`;
    document.getElementById(`rate_d`).style.boxShadow = `none`;

    document.getElementById("buttons").style.opacity = "1";
    
    await sleep(1000);
    document.getElementById("a").style.opacity = "1";
    await sleep(1000);
    document.getElementById("b").style.opacity = "1";
    await sleep(1000);
    document.getElementById("c").style.opacity = "1";
    await sleep(1000);
    document.getElementById("d").style.opacity = "1";
}

function spawn_fireworks()
{
    document.getElementById("f1").style.display = `grid`;
}

async function update_profile(a,b,c)
{
    document.getElementById("profile").style.opacity = "0";

    document.getElementById("name").innerText = `Name: ${a}`;
    document.getElementById("group").innerText = `Group: ${b}`;
    document.getElementById("score").innerText = `Score: ${c}`;

    document.getElementById("profile").style.opacity = "1";
}

function reset_op()
{
    document.getElementById("a").style.opacity = "0";
    document.getElementById("b").style.opacity = "0";
    document.getElementById("c").style.opacity = "0";
    document.getElementById("d").style.opacity = "0";
}

// main.js part

var xhr;
var sentence;
var question;
var canAnswer = false;
let score=0;
let last_score=0;
var c;
var uuid;
var selected=0;
var ready = false;
var group;
var id;
var s=false;
var ans=0;
var winner = '';
var users = [];
var groups = ["a","b","c","d","f"]
var index=0;
var correct_audio = new Audio('./audio/correct.mp3');
var final_audio = new Audio('./audio/final.mp3');
var timer_audio = new Audio('./audio/timer.mp3');
var end_audio = new Audio('./audio/bell.mp3');

function sleep (time) {
    return new Promise((resolve) => setTimeout(resolve, time));
}

async function start_timer()
{
    
    var max = 10;
    document.getElementById("timer").style.backgroundColor = "lime";


    timer_audio.currentTime=0;
    end_audio.currentTime=0;
    
    timer_audio.play();

    for (let step = 0; step < max; step++) 
    {
        document.getElementById("t").innerText = `${max - step}`;
        score=(max-step)*100;
        await sleep(1000);
    }

    document.getElementById("t").innerText = `UP`;
    document.getElementById("timer").style.backgroundColor = "red";
    timer_audio.pause();

    end_audio.play();

    await sleep(2000);

    show_rate();

    score=0;
    canAnswer = false;
}

function connect_all()
{
    ws.addEventListener("open", async () =>{
        //document.getElementById("socket").innerHTML = "<h1>Connected</h1>";
        await update_m2("Waiting to start");
        await sleep(500);
    });

    ws.addEventListener('close', async function () {
        await update_m2("Disconnected, please return to main menu and try again");
        await sleep(500);
    });

    ws.addEventListener('message', async function (event) {
        if(event.data!='')
        {
            var j = JSON.parse(event.data.replaceAll(`'`, `"`));

            if(j.command == "ready")
            {
                document.getElementById("board").style.opacity = "0";

                if(j.group == "d")
                    await update_m2(`Starting Top 5 : Finals`);
                else if(j.group == "a")
                    await update_m2(`Starting Top 80-40`);
               	else if(j.group == "b")
                    await update_m2(`Starting Top 30`);
                else if(j.group == "c")
                    await update_m2(`Starting Top 15`);

                ready=true;
            }
            else if(j.command == "new")
            {
                show_names(j.count);
            }
            else if(j.command == "reset")
            {
                show_names(j.count);
            }
            else if(j.command == "board")
            {
                show_board_tmp();
            }
            else if(j.command == "equal")
            {
                show_board();
            }
            
            if(ready)
            {
                if(j.command == "go")
                {
                    question = j.question;
                    reset_op();
                    get_question();
                }
                else if(j.command == "start")
                {
                    score=0;
                    canAnswer=true;
                    await start_timer();
                }
                else if(j.command == "win")
                {
                    //await update_m2(`Group ${groups[index]} Leaderboard:`);
                    //show_board();
                    show_stats();
                }
                else if(j.command == "final")
                {
                    show_board_final();
                }
            }

        }
    });
}

function get_question()
{
    if(ans!=0)
    {
        document.getElementById(ans).style.cssText = `
                border-color: black;
                border-width: 3px;
            `
        s=false;
    }
    else
    {
        document.getElementById("rates").style.opacity = "0";
        document.getElementById("rate_a").style.opacity = "0";
        document.getElementById("rate_b").style.opacity = "0";
        document.getElementById("rate_c").style.opacity = "0";
        document.getElementById("rate_d").style.opacity = "0";

        document.getElementById("buttons").style.top = "60%";
    }

    document.getElementById(`group`).style.opacity = "0";
    document.getElementById("buttons").style.opacity = "0";
    const value = ('; '+document.cookie).split(`; sessionID=`).pop().split(';')[0];
    xhr = new XMLHttpRequest();
    xhr.open("GET", `http://${domain}:8000/api/getQuestion?id=${question}`, true);
    xhr.send(`{"sessionID":"${value}"}`);

    xhr.onload = async function() {
        const obj = JSON.parse(xhr.responseText);
        update_alert(`${obj.content}`);
        await sleep(1000);
        spawn_buttons(obj.a,obj.b,obj.c,obj.d);
        document.getElementById("t").innerText = `10`;
        document.getElementById("timer").style.backgroundColor = "lightblue";
        await sleep(500);
        document.getElementById("timer").style.opacity = "1";
    }
}


function show_rate()
{
    xhr = new XMLHttpRequest();
    xhr.open("GET", `http://${domain}:8000/api/hxhx?code=${keyword}&question=${question}`, true);
    xhr.send();
    
    xhr.onload = async function() 
    {
        var txt = JSON.parse(xhr.responseText);

        answer = txt.answer;

        document.getElementById(`rate_${String(answer)}`).style.boxShadow = `0 0 10px 10px #00ffff`;

        document.getElementById("message").style.opacity = "0";
        document.getElementById("buttons").style.opacity = "0";
        document.getElementById("timer").style.opacity = "0";

        await sleep(500);
        
        correct_audio.play();

        document.getElementById("rates").style.opacity = `1`;
        document.getElementById("rate_a").style.opacity = `1`;
        document.getElementById("rate_b").style.opacity = `1`;
        document.getElementById("rate_c").style.opacity = `1`;
        document.getElementById("rate_d").style.opacity = `1`;

        
  
    }
}

function show_board()
{
    xhr = new XMLHttpRequest();
    xhr.open("GET", `http://${domain}:8000/api/getLeaderboard?group=${groups[index]}`, true);
    xhr.send();

    xhr.onload = async function()
    {

        document.getElementById(`group`).style.opacity = "0";    
        await sleep(1000);
        document.getElementById(`group`).innerHTML = ""; 

        var elem = ["message","buttons","rates","timer"];
        var elems2  = [];

        elem.forEach(function(dv)
        {
            // check if visible, if yes opacity = 0
            var l = window.getComputedStyle(document.getElementById(dv)).opacity.toString();
            
            if(l.localeCompare("0"))
            {
                elems2.push(dv);
                document.getElementById(dv).style.opacity = "0";
            }
            // else remove from lise
        });

        var l = JSON.parse(xhr.responseText);
        var s=l.length;
        var check=false;
        var n_list = [];
        var n_next_list = [];

        document.getElementById("group").innerHTML = ``;

        for (let step = 0; step < s; step++) 
        {
            var values = Object.values(l[step][1]);

            var name = values[0];
            var last = values[1];
            var g = values[3];

            if(g==groups[index+1])
            {
                check=true;
                n_next_list.push(name.concat(" ", last));
            }
            else if(g==groups[index])
            {
                n_list.push(name.concat(" ", last));
            }

            //document.getElementById(`group`).innerHTML += `<h3 class="item">${name}</h3>`;

        }

        if(check)
        {
            for(let step=0; step<n_next_list.length; step++)
            {
                document.getElementById(`group`).innerHTML += `<h3 class="item">${n_next_list[step]}</h3>`;
            }

            await update_m2(`Moving to the next round`);
            index+=1;
        }
        else
        {
            for(let step=0; step<n_list.length; step++)
            {
                document.getElementById(`group`).innerHTML += `<h3 class="item">${n_list[step]}</h3>`;
            }

            await update_m2(`Waiting for additional questions...`);
        }

        document.getElementById("group").style.opacity = "1";

    }
}

function show_board_tmp()
{
    xhr = new XMLHttpRequest();
    xhr.open("GET", `http://${domain}:8000/api/getLeaderboard?group=${groups[index]}`, true);
    xhr.send();

    xhr.onload = async function(){

        document.getElementById(`group`).style.opacity = "0";

        var elem = ["message","buttons","timer","rate_a","rate_b","rate_c","rate_d","rates"];
        var elems2  = [];

        elem.forEach(function(dv)
        {
            // check if visible, if yes opacity = 0
            var l = window.getComputedStyle(document.getElementById(dv)).opacity.toString();
            
            if(l.localeCompare("0"))
            {
                elems2.push(dv);
                document.getElementById(dv).style.opacity = "0";
            }
            // else remove from lise
        });

        var l = JSON.parse(xhr.responseText);
        var s=l.length;

        document.getElementById("group").innerHTML = ``;

        for (let step = 0; step < s; step++) 
        {
            var values = Object.values(l[step][1]);

            var name = values[0];
            var last = values[1];
            var g = values[3];

            if(g==groups[index])
            {
                document.getElementById(`group`).innerHTML += `<h3 class="item">${name} ${last}</h3>`;
            }
        }

        await sleep(500);

        await update_m2(`Current players: `);
        document.getElementById(`group`).style.opacity = "1";

        await sleep(2000);

        document.getElementById(`group`).style.opacity = "0";
        document.getElementById("main_message").style.opacity = "0";


        await sleep(1000);

        for ( var i=0; i<elems2.length; i++)
        {
            document.getElementById(elems2[i]).style.opacity = "1";
        }

    }
}

function show_board_final()
{
    xhr = new XMLHttpRequest();
    xhr.open("GET", `http://${domain}:8000/api/getLeaderboard?group=${groups[index]}`, true);
    xhr.send();
    var list = [];
    var list2 = [];

    xhr.onload = async function()
    {
        
        document.getElementById(`group`).style.opacity = "0";

        var elem = ["message","buttons","rates","timer"];
        var elems2  = [];
        var winner;

        elem.forEach(function(dv)
        {
            // check if visible, if yes opacity = 0
            var l = window.getComputedStyle(document.getElementById(dv)).opacity.toString();
            
            if(l.localeCompare("0"))
            {
                elems2.push(dv);
                document.getElementById(dv).style.opacity = "0";
            }
            // else remove from lise
        });

        var l = JSON.parse(xhr.responseText);
        var s=l.length;
        var check=false;

        document.getElementById("group").innerHTML = ``;

        for (let step = 0; step < s; step++) 
        {
            var values = Object.values(l[step][1]);

            var name = values[0];
            var last = values[1];
            var score = values[2];
            var g = values[3];

            document.getElementById(`group`).innerHTML += `<h3 class="item">${name.concat(" ",last)}</h3>`;

            if(g=="f")
            {
                winner=name.concat(" ", last);
            }
            else
            {
                list.push(name);
                list2.push(last);
            }

        }

        if(winner)
        {
            for (let step = 0; step < 4; step++) 
            {
                document.getElementById("ranks").innerHTML += `
                <div class="classement">
                    <h1>${step+2}</h1>
                    <h2>${list[step]} ${list2[step]}</h2>
                </div>`
            }
            final_audio.play();
            await update_m2(`The winner is: `);
            spawn_fireworks();
            document.getElementById("ranks").style.opacity = `1`;
            await sleep(9000);
            document.getElementById("ranks").style.opacity = `0`;
            await sleep(1000);
            document.getElementById(`winner`).innerText = `${winner}`;
            document.getElementById(`winner`).style.opacity = `1`;
            document.getElementById(`winner`).style.scale = `2.5`;
            document.getElementById(`group`).style.display = `none`;
            
        }
        else
        {
            await update_m2(`Waiting for additional questions...`);
            document.getElementById(`group`).style.opacity = "1";
        }

    }
}

function show_names(c)
{
    xhr = new XMLHttpRequest();
    xhr.open("GET", `http://${domain}:8000/api/getUsers`, true);
    xhr.send();

    xhr.onload = async function()
    {
        var l = JSON.parse(xhr.responseText);


        document.getElementById(`group`).style.opacity = "0";    
        await sleep(1000);
        document.getElementById(`c1`).innerText = `Current Players: ${c-1}`
        document.getElementById(`group`).innerHTML = ``;

        for (let step = 0; step < Object.keys(l).length; step++) 
        {
            n = l[`${step}`].name;
            last = l[`${step}`].last;
            g = l[`${step}`].group;

            full = n.concat(" ", last);

            if(!(users.includes(full))){
                users.push(full);
            }

            document.getElementById(`group`).innerHTML += `<h3 class="item">${full}</h3>`;
        }

        document.getElementById(`group`).style.opacity = "1";    
        
    }
}

function reset()
{
    if(ws.readyState !== WebSocket.CLOSED)
    {
        ws.close();
    }
    
    window.location.reload();
}

async function show_stats()
{
    xhr = new XMLHttpRequest();
    xhr.open("GET", `http://${domain}:8000/api/getLeaderboard?group=${groups[index]}`, true);
    xhr.send();
    var list = [];
    var list2 = [];

    xhr.onload = async function()
    {
       
        //document.getElementById("leader").style.opacity = "0";

        var elem = ["message","buttons","rates","timer"];
        var elems2  = [];
        var winner;

        elem.forEach(function(dv)
        {
            var l = window.getComputedStyle(document.getElementById(dv)).opacity.toString();
           
            if(l.localeCompare("0"))
            {
                elems2.push(dv);
                document.getElementById(dv).style.opacity = "0";
            }
        });

        var l = JSON.parse(xhr.responseText);
        var s=l.length;
        var check=false;

        var tmp = [];

        document.getElementById(`group`).style.opacity = "1";

        // 14 its clear then repeat
        for (let step = 0; step < s; step++)
        {
                var values = Object.values(l[step][1]);
                tmp.push(values);
        }

        document.getElementById(`group`).style.opacity = "0";    
        await sleep(1000);
        document.getElementById(`group`).innerHTML = "";    

        for(let i=0;i<s;i++)
        {
            var element = tmp[i];
           
            var name = element[0];
            var last = element[1];
            var score = element[2];
            var g = element[3];
            var counter = element[4] / element[5];
            var answered = element[5];

            counter = counter || 0;

            if(i%10 == 0 && i!= 0)
            {
                await sleep(500);
                document.getElementById(`group`).style.opacity = "1";
                await sleep(10000);

                document.getElementById(`group`).style.opacity = "0";
                await sleep(500);
                document.getElementById(`group`).innerHTML = '';
                await sleep(500);
            }

            if(g==groups[index+1])
            {
                document.getElementById(`group`).innerHTML += `
                <div class="stat" style="background-color: wheat;">
                    <h1>${name} ${last}</h1>
                    <h2>Rank: ${tmp.indexOf(element)+1}</h2>
                    <h2>Score: ${score}</h2>
                    <h2>Seconds per answer: ${counter.toFixed(2)}</h2>
                    <h2>Correct Answers: ${answered}</h2>
                </div>
                `
            }
            else if(g=="l" || g=="fl")
            {
                document.getElementById(`group`).innerHTML += `
                <div class="stat" style="background-color: red;">
                    <h1>${name} ${last}</h1>
                    <h2>Rank: ${tmp.indexOf(element)+1}</h2>
                    <h2>Score: ${score}</h2>
                    <h2>Seconds per answer: ${counter.toFixed(2)}</h2>
                    <h2>Correct Answers: ${answered}</h2>
                </div>
                `
            }
        }

        document.getElementById(`group`).style.opacity = "1";
        await sleep(10000);

        await show_board();
    }
}

connect_all();
  
