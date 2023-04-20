
# This will trigger an app.yml workflow
def player(event, context):
    message = "Hello {}!".format(event['key1'])
    return {
        'message' : message
    }
