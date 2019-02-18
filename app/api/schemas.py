from marshmallow import Schema, fields

class ContactSchema(Schema):
    subject = fields.Str(required=True)
    email = fields.Str(required=True)
    message = fields.Str(required=True)

