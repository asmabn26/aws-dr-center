import boto3

session = boto3.Session(profile_name="your-aws-profile")
sts = session.client("sts")

identity = sts.get_caller_identity()

print("Compte AWS :", identity["Account"])
print("ARN :", identity["Arn"])