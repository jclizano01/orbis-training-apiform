# -*- coding: utf-8 -*-
from __future__ import print_function

import json

from api.utils.exceptions import ExceptionHandler
from api.utils.config import get_config_env
from api.utils.response import prepare_response
from api.resources import ContactResource


def main(event, context):
    response = prepare_response(200, {})
    try:
        print('Obterner variables de ambiente')
        config = get_config_env()

        print('Procesar data recibida')
        contact = ContactResource(config)
        response = contact.on_post(json.loads(event['body']))
    except ExceptionHandler as error:
        logger.error(str(error))
        response = prepare_response(509, {'message': str(error) })

    return response

if __name__ == "__main__":
    main('', '')