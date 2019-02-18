import boto3
import uuid
from datetime import datetime

# Get the service resource.
dynamodb = boto3.resource('dynamodb')

class Table(object):
    
    def __init__(self, name):
        self.name = name
        self.table = dynamodb.Table(self.name)

    def save(self, data):
        id = str(uuid.uuid4())
        data.update({
            'id': id,
            'create_at': str(datetime.now())
        })
        self.table.put_item(Item = data)
        return id

    def get_by_id(self, id):
       key = {'id': id}
       return self.table.get_item(Key = key)

    def get_by_email(self, email):
       key = {'email': email}
       return self.table.get_item(Key = key)