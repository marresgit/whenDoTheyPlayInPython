
# This will update script in lambda
def player(event, context):
    message = "Hello {}!".format(event['key1'])
    return {
        'message' : message
    }
