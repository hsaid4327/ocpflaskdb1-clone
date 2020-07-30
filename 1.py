#!/usr/bin/python3
#
#   Connect to Azure DB
#   Run SQL query
#   Display some output to prove it
#   password for dbpass need to be set

import pandas as pd
import pyodbc
from flask import Flask, redirect, url_for

dbserv='uswsql2.azvms.com,51005'
dbname='mfgnetdev'
dbuser='mfgnetuser'
dbpass='mfgnetuser'
#conn = pyodbc.connect('DSN=TNSDB;SERVER='+ dbserv +';DATABASE='+ dbname +';UID='+ dbuser +';PWD='+ dbpass)
conn = pyodbc.connect('DSN=TNSDB;SERVER=uswsql2.azvms.com,51005;DATABASE=mfgnetdev;UID=mfgnetuser;PWD=mfgnetuser')
site_code = 'fxc'
sql_site="select site_name from sites where site_code = '" +  site_code + "'"

app = Flask(__name__)

@app.route("/site/")
def site():
    return f"Hello {site_code}!"

@app.route("/webhook/")
def site():
    return f"Hello webhook is working!"

@app.route("/fxc/")
def fxc():
    df_site=pd.read_sql(sql_site,conn)
    return f"Hello {df_site}!"    

@app.route("/home/")
def home():
    return "Hello! this is the main page <H1> HELLO </H1>"


@app.route("/<name>")
def user(name):
    return f"Hello {name}!"

@app.route("/admin")
def admin():
    return redirect(url_for("home")
    
    )
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
