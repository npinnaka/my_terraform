import json

def lambda_handler(event, context):
    return json.dumps({"response": "welcome to lambda"})