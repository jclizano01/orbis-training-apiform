# -*- coding: utf-8 -*-
import os

def get_config_env():
    config = {
        'DB_TABLE': os.getenv('DB_TABLE')
    }
    return config