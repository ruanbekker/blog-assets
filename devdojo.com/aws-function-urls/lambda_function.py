import json

def lambda_hander(event, context):
    print(event)
    return {
        "statusCode": 200,
        "body": json.dumps(event)
    }
