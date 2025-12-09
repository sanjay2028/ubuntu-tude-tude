import os
import certifi
from flask import Flask, request, jsonify,make_response
from pymongo import MongoClient
from dotenv import load_dotenv
load_dotenv()

app = Flask(__name__)

MONGODB_URL = os.getenv("MONGODBURL")
DB_NAME = os.getenv("DB_NAME")
collection = os.getenv("MEMBER_COLLECTION")

client: MongoClient = MongoClient(  MONGODB_URL, 
                                    tls=True,
                                    tlsCAFile=certifi.where(),
                                    serverSelectionTimeoutMS=30000
                                )
db = client[DB_NAME]
members = db[collection]


@app.route("/heartbeat", methods=["GET"])
def healthCheck():
    return make_response(jsonify({ "status": "OK" }), 200)


@app.route("/add", methods=["POST"])
def registration():
    jsonData = request.get_json()
    form_errors = {}
   
    name = jsonData.get("name")
    age = jsonData.get("age")

    if not name:
        form_errors["name"] = "Name is a required field" 

    try:
        age = int(age or 0)    
        if(age == 0):
            form_errors["age"] = "Age must be numeric and cannot be 0."
    except ValueError as E:
        form_errors["age"] = "Invalid age value"

    if(len(form_errors)):
        return make_response(jsonify(form_errors), 422)
    else:
        try:
            userData = { "name": name, "age":age }
            data = members.insert_one(userData)

            print("AtlasResponse >>>>>>>>>> ", data)

            return make_response(jsonify({ "name": name, "age":age }), 200)
        except Exception as e:
            print(e)
            return make_response(jsonify({ "db_error": "Failed to add the reord to db"}), 513)
    


if __name__ == "__main__":
    app.run(port=5000, host="0.0.0.0", debug=True)


