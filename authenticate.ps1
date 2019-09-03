$AWSPROFILE = Read-Host -Prompt 'Specify AWS-CLI profile'
$MFASERIAL = Read-Host -Prompt 'Enter MFA device serial number or AWS ARN'
$MFACODE = Read-Host -Prompt 'Enter MFA code'

#Hard coded examples
#$AWSPROFILE='testmfauser'
#$MFASERIAL='arn:aws:iam::123456789012:mfa/testmfauser'

# Get temporary credentials
$result = aws sts get-session-token --serial-number $MFASERIAL --token-code $MFACODE --profile $AWSPROFILE | ConvertFrom-Json

# Overriding credentials using enviroment variables which takes precedent over configured profiles/credentials
$env:AWS_ACCESS_KEY_ID = $result.Credentials.AccessKeyId
$env:AWS_SECRET_ACCESS_KEY = $result.Credentials.SecretAccessKey
$env:AWS_SESSION_TOKEN = $result.Credentials.SessionToken

# Print logged-in user details using opsworks API
aws opsworks describe-my-user-profile