import boto3
import os
import json
import hashlib
import datetime

aws_key = open('/var/openfaas/secrets/openfaas-aws-access-key', 'r').read()
aws_secret = open('/var/openfaas/secrets/openfaas-aws-secret-key', 'r').read()
dynamodb_region = os.environ['dynamodb_region']
dynamodb_table  = os.environ['dynamodb_table']

client = boto3.Session(region_name=dynamodb_region).resource('dynamodb', aws_access_key_id=aws_key, aws_secret_access_key=aws_secret)
table = client.Table(dynamodb_table)

def calc_sha(id_number, lastname):
    string = json.dumps({"id": id_number, "lastname": lastname}, sort_keys=True)
    hash_value = hashlib.sha1(string.encode("utf-8")).hexdigest()
    return hash_value

def create_timestamp():
    response = datetime.datetime.now().strftime("%Y-%m-%dT%H:%M")
    return response

def handle(req):
    event = json.loads(req)
    unique_id = calc_sha(event['id'], event['lastname'])
    response = table.put_item(
        Item={
            'hash_value': unique_id,
            'timestamp': create_timestamp(),
            'payload': event['payload']
        }
    )
    return response
