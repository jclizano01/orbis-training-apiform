import json
from .schemas import ContactSchema
from .utils.exceptions import ExceptionHandler
from .utils.response import prepare_response
from .utils.database import Table

class ContactResource(object):

    def __init__(self, config):
        self.config = config

    def validate_payload(self, payload):
        errors = ContactSchema().validate(payload)
        if len(errors) > 0:
            raise ExceptionHandler(json.dumps(errors))

    def on_post(self, payload):
        print('Payload recibido:')
        print(json.dumps(payload, indent=4))
        print('Validar payload')
        self.validate_payload(payload)
        
        print('Guardar data')
        table = Table(self.config['DB_TABLE'])
        id = table.save(payload)
        status_code = 200
        data = {
            'message':'record successfully',
            'data': {
                'recordId': id
            }
        }

        print('Preparar respuesta')
        response = prepare_response(
            status_code, 
            data
        )

        return response