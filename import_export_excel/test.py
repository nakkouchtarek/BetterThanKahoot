import pandas as pd
import xlsxwriter
import mysql.connector
import sys

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password=""
)

commands = ["import","export"]

mycursor = mydb.cursor()

mycursor.execute("USE quiz;")

def leave():
    print("Usage: python $PATH$/main.py export|import $filename$.xlsx")
    exit(0)

def insert_question(content,a,b,c,d,answer,category):
    mycursor.execute(f"INSERT INTO `test`(`content`, `a`, `b`, `c`, `d`, `answer`, `category`) VALUES ('{str(content)}','{str(a)}','{str(b)}','{str(c)}','{str(d)}','{str(answer)}','{str(category)}');")
    mydb.commit()

def import_file(file):
    data = pd.read_excel(fr'{file}')
    df = pd.DataFrame(data, columns=['content', 'a', 'b', 'c', 'd', 'answer', 'category'])

    count = 0

    while True:
        try:
            if df['content'][count] != '':
                count += 1
        except:
            break

    for i in range(count):
        if str(df['answer'][i]) == "1":
            answer = "a"
        elif str(df['answer'][i]) == "2":
            answer = "b"
        elif str(df['answer'][i]) == "3":
            answer = "c"
        elif str(df['answer'][i]) == "4":
            answer = "d"

        insert_question(str(df['content'][i]).replace('"',"").replace("'",""), str(df['a'][i]).replace('"',"").replace("'",""), 
                        str(df['b'][i]).replace('"',"").replace("'",""), str(df['c'][i]).replace('"',"").replace("'",""), 
                        str(df['d'][i]).replace('"',"").replace("'",""), answer, df['category'][i])

def export_file(file):
    workbook = xlsxwriter.Workbook(f'{file}')

    worksheet = workbook.add_worksheet()

    row=0
    col=0

    worksheet.write(row, col, "content")
    worksheet.write(row, col+1, "a")
    worksheet.write(row, col+2, "b")
    worksheet.write(row, col+3, "c")
    worksheet.write(row, col+4, "d")
    worksheet.write(row, col+5, "answer")
    worksheet.write(row, col+6, "category")

    row += 1
    col = 0

    mycursor.execute("SELECT * FROM test;")

    for res in mycursor.fetchall():

        worksheet.write(row, col, res[1])
        worksheet.write(row, col+1, res[2])
        worksheet.write(row, col+2, res[3])
        worksheet.write(row, col+3, res[4])
        worksheet.write(row, col+4, res[5])
        worksheet.write(row, col+5, res[6])
        worksheet.write(row, col+6, res[7])

        col = 0
        row += 1
        
    
    workbook.close()


# ALTER TABLE table_name AUTO_INCREMENT = value;
# reset inc value ( value == next value of inc )

if len(sys.argv) < 3:
    leave()
else:
    if (sys.argv[1] in commands) and ( ( len(sys.argv[2].split(".")) > 1) and (sys.argv[2].split(".")[1] == "xlsx") ):
        if(sys.argv[1] == "import"):
            import_file(sys.argv[2])
        else:
            export_file(sys.argv[2])
    else:
        leave()
