import boto3
import os
import json

aws_key = open('/var/openfaas/secrets/openfaas-aws-access-key', 'r').read()
aws_secret = open('/var/openfaas/secrets/openfaas-aws-secret-key', 'r').read()
dynamodb_region = os.environ['dynamodb_region']
dynamodb_table  = os.environ['dynamodb_table']

client = boto3.Session(region_name=dynamodb_region).resource('dynamodb', aws_access_key_id=aws_key, aws_secret_access_key=aws_secret)
table = client.Table(dynamodb_table)

def handle(req):
    event = json.loads(req)
    response = table.get_item(
        Key={
            'hash_value': event['hash_value']
        }
    )

    if 'Item' not in response:
        item_data = 'Item not found'
    else:
        item_data = response['Item']

    return item_data
