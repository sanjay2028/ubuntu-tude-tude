import os
from flask import Flask, jsonify, render_template, request, redirect, url_for
from dotenv import load_dotenv
from pymongo import MongoClient
import json

load_dotenv()
app = Flask(__name__)
MONGODBURL = os.getenv("MONGODBURL")
DB_NAME = os.getenv("DB_NAME")
dbClient: MongoClient = MongoClient(MONGODBURL);
db = dbClient["training-flask-api"]
members = db["members"]


@app.route("/")
def index():
    return "Welcome to index page."

@app.route("/api")
def api():

    """
    Problem statement:
    1.  Create a Flask application with an /api route. 
        When this route is accessed, it should return a JSON list. 
        The data should be stored in a backend file, read from it, and sent as a response.

    Solution Explanation:
    - Open the file data.json in a read mode
    - use with method to open the file with read only flag
    - Since the file will be read as a JSON, use json package to convert the data into python dictionary
    - store the python dict in data. 
    - return the data as an output.
    """

    with open("data.json", "r") as handler:
        data =  json.load(handler)
    return jsonify(data)

@app.route("/success", methods=["GET"])
def success():
    return render_template("submission_success.html")

@app.route("/form-submission", methods=["GET", "POST"])
def form():
    """
        2. Create a form on the frontend that, when submitted, inserts data into MongoDB Atlas. 
            Upon successful submission, the user should be redirected to another page displaying 
            the message "Data submitted successfully". 
            If there's an error during submission, display the error on the same page without redirection.
    """
    form_errors = []
    values = { "name": "", "age": ""}
    template_data = {        
        "form_name": "User Information Form"
    }

    if(request.method == 'POST'):        
        name = request.form.get('name')
        values["name"] = name        
        if not name:
            form_errors.append("Name is a required field") 
             
        try:
            age = int(request.form.get('age') or 0)
            values["age"] = age
            if(age == 0):
                form_errors.append("Age cannot be 0.")
        except ValueError as E:
            form_errors.append("Invalid age value")
        
        if(len(form_errors) == 0):

            try:
                members.insert_one({"name": name, "age": age})
                return redirect(url_for('success'))
            except Exception as E:
                print(E)
                form_errors.append("Failed to add record to database")
                
            


    template_data  = { "form_name": "User Information Form", "errors": form_errors, "values": values}

    print(template_data)
    return render_template("form.html", data=template_data)


if __name__ == "__main__":
    app.run(debug=True)

