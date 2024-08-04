import boto3
import os

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    source_bucket = os.environ['SOURCE_BUCKET']
    destination_bucket = os.environ['DESTINATION_BUCKET'] 

    
    try:
        for record in event['Records']:
            source_bucket = record['s3']['bucket']['name']
            key = record['s3']['object']['key']
            
            copy_source = {'Bucket': source_bucket, 'Key': key}
            s3.copy_object(CopySource=copy_source, Bucket=destination_bucket, Key=key)
        
        return {
            'statusCode': 200,
            'body': f'File moved from {source_bucket}/{key} to {desttination_bucket}/{key}'
        }
    except KeyError as e:
        print(f"KeyError: {e}")
        return {
            'statusCode': 400,
            'body': f"KeyError: {e}"
        }
