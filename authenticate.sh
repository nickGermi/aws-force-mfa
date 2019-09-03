read -p "Specify AWS profile: " AWSPROFILE
read -p "Enter MFA device serial number or AWS ARN: " MFASERIAL
read -p "Enter MFA code: " MFACODE

#Hard coded examples
#AWSPROFILE='testmfauser'
#MFASERIAL='arn:aws:iam::123456789012:mfa/testmfauser'

# Get temporary credentials
result="$(aws sts get-session-token --serial-number $MFASERIAL --token-code $MFACODE --profile $AWSPROFILE)"

# Overriding credentials using enviroment variables which takes precedent over configured profiles/credentials
export AWS_ACCESS_KEY_ID=$(jq -r '.Credentials.AccessKeyId' <<< $result)
export AWS_SECRET_ACCESS_KEY=$(jq -r '.Credentials.SecretAccessKey' <<< $result)
export AWS_SESSION_TOKEN=$(jq -r '.Credentials.SessionToken' <<< $result)

# Print logged-in user details using opsworks API
aws opsworks describe-my-user-profile