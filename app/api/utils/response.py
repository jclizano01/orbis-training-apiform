import json    

CONTENT_TYPE_JSON = "application/json"

def prepare_response(status_code, data):
    response = {
        "statusCode": status_code, 
        "headers": {"Content-Type": CONTENT_TYPE_JSON},
        "body": json.dumps(data)
    }
    return response