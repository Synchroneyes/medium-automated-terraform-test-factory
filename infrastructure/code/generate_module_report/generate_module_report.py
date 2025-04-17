import boto3
import json
import os


def generate_report_content(items):
    report = "Daily Module Report\n\n"
    for item in items:
        module_name = item['ModuleName']['S']
        module_version = item['ModuleVersion']['S']
        module_status = item['ModuleStatus']['S']
        module_url = item['ModuleUrl']['S']
        
        report += "-" * 20 + "\n"
        report += f"Module Name: {module_name}\n"
        report += f"Module Version: {module_version}\n"
        report += f"Module Status: {module_status}\n"
        report += f"Module URL: {module_url}\n"
        
    return report

def handler(event, context):

    # Create a DynamoDB client
    dynamodb = boto3.client('dynamodb')

    # Define the table name
    table_name = os.environ['DYNAMODB_TABLE_NAME']

    # Fetch all items from the DynamoDB table
    try:
        response = dynamodb.scan(
            TableName=table_name
        )
        items = response.get('Items', [])

        if not items or len(items) == 0:
            return {
                'statusCode': 200,
                'body': json.dumps('No items found in the DynamoDB table.')
            }
       
        failed_item_count = 0
        for item in items:
            module_status = item['ModuleStatus']['S']
            if module_status != 'success':
                failed_item_count += 1

        email_content = generate_report_content(items)

        # send message content to SNS
        sns = boto3.client('sns')
        topic_arn = os.environ['SNS_TOPIC_ARN']
        subject = os.environ['EMAIL_SUBJECT']

        sns.publish(
            TopicArn=topic_arn,
            Subject=f"{subject} - {failed_item_count} failed/total {len(items)}",
            Message=email_content,
            MessageStructure='string'
        )

        # Clear data in the DynamoDB table
        for item in items:
            dynamodb.delete_item(
                TableName=table_name,
                Key={
                    'ModuleName': item['ModuleName'],
                    'ModuleVersion': item['ModuleVersion']
                }
            )

        return {
            'statusCode': 200,
            'body': json.dumps(f"Send message: {email_content} to SNS")
        }


    except Exception as e:
        raise Exception(f'Error fetching module results: {str(e)}')
