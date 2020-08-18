import os

def lambda_handler(event, context):
    return "{} from another Lambda!".format(os.environ['greeting'])