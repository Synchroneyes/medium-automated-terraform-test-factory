import boto3
import json
import os

def handler(event, context):

    module_name = event['module_name']
    module_version = event['module_version']
    module_status = event['module_status']
    module_url = event['module_url']

    # Create a DynamoDB client
    dynamodb = boto3.client('dynamodb')
    
    # Define the table name
    table_name = os.environ['DYNAMODB_TABLE_NAME']

    # Create the item to be inserted
    item = {
        'ModuleName': {'S': module_name},
        'ModuleVersion': {'S': module_version},
        'ModuleStatus': {'S': module_status},
        'ModuleUrl': {'S': module_url}
    }

    # Insert the item into the DynamoDB table
    try:
        response = dynamodb.put_item(
            TableName=table_name,
            Item=item
        )
        return {
            'statusCode': 200,
            'body': json.dumps('Module result registered successfully!')
        }
    except Exception as e:
        raise Exception(f'Error registering module result: {str(e)}')