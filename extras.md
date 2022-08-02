### ASSUMEROLE POLICY

-- This returns a set of temporary security credentials that one can use to access AWS resources that you might not normally have access to. 
-- These temporary credentials consist of an access key ID, a secret access key, and a security token. 
-- AssumeRole can be used within one's account or for cross-account access. 
The temporary security credentials created by AssumeRole can be used to make API calls to any AWS service with the following exception: 
You cannot call the AWS STS GetFederationToken or GetSessionToken API operations.