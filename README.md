## Enforce multi-factor authentication for AWS IAM Console & CLI users

##### Instructions to enforce MFA for IAM users for Admins
1. Attach provided [IAM policy](Enforce_MFA_IAM_Policy.json) for applicable IAM users

##### Instructions to enable MFA on AWS Console for IAM users
1. Login to AWS Console using your credentials (It's ok to see Unauthorized errors within the page)
2. Click on your name on top right corner and select My Security Credentials or once logged-in, navigate to https://console.aws.amazon.com/iam/home?#my_password
3. Add MFA Device (Either hardware or virtual such as Microsoft Authenticator or Okta-Verify)
4. Make a note of your MFA device ARN if you wish to use AWS CLI

###### Notes
- Once enabled, users cannot disable MFA!
- Provided scripts assume AWS-CLI has been configured with a default region and default output format (JSON).
- Scripts add temporary MFA enabled AWS credentials to enviroment variables within the bash/powershell session and are destroyed once session is closed.
- If you are using an EC2 instance or assuming a role in order to access AWS-CLI, you may simply put an additional parameter to aws config file as follows instead and AWS-CLI will automatically check for MFA code. ([See AWS-CLI Reference](https://docs.aws.amazon.com/cli/latest/topic/config-vars.html))
    mfa_serial = <mfa-device-arn>

##### AWS-CLI Access

You'll need to call AWS STS service in order to request a new set of temporary credentials while also providing the MFA token. Provided scripts will assist you in doing so.

- authenticate.sh for BASH (requires [JQ](https://stedolan.github.io/jq/))
    ```
    chmod +x authenticate.sh
    ./authenticate.sh
    ```

- authenticate.sh for OSX (requires [JQ](https://stedolan.github.io/jq/))
    ```
    chmod +x authenticate.sh
    source ./authenticate.sh
    ```

- authenticate.ps1 for PowerShell
    ```
    .\authenticate.ps1
    ```

###### Input parameters:
- AWS-CLI configuration profile name `can be hard coded`
- MFA device serial number or ARN `can be hard coded`
- MFA code

#### References
* [AWS-CLI](https://aws.amazon.com/cli/) - AWS Command line interface
* [JQ](https://stedolan.github.io/jq/) - JSON Parser

License
----

MIT

Author
----
Nick Germi
