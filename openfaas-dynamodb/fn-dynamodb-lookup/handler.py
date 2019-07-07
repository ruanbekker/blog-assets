import json
import hashlib

def calc_sha(id_number, lastname):
    string = json.dumps({"id": id_number, "lastname": lastname}, sort_keys=True)
    hash_value = hashlib.sha1(string.encode("utf-8")).hexdigest()
    return hash_value

def handle(req):
    event = json.loads(req)
    hash_value = calc_sha(event['id'], event['lastname'])
    return hash_value
