### ASSUMEROLE POLICY

-- This returns a set of temporary security credentials that one can use to access AWS resources that you might not normally have access to. 
-- These temporary credentials consist of an access key ID, a secret access key, and a security token. 
-- AssumeRole can be used within one's account or for cross-account access. 
-- The temporary security credentials created by AssumeRole can be used to make API calls to any AWS service with the following exception: 
-- You cannot call the AWS STS GetFederationToken or GetSessionToken API operations.

### ROLE POLICY
IAM Roles manage who has access to your AWS resources, whereas IAM policies control their permissions. 
A Role with no Policy attached to it won't have to access any AWS resources.
The difference between IAM roles and policies in AWS is that a role is a type of IAM identity that 
can be authenticated and authorized to utilize an AWS resource, whereas a policy defines the permissions of the IAM identity.

An IP address is a unique address that identifies a device on the internet or a local network. IP stands for "Internet Protocol," 
which is the set of rules governing the format of data sent via the internet or local network.

In essence, IP addresses are the identifier that allows information to be sent between devices on a network: they contain location 
information and make devices accessible for communication. The internet needs a way to differentiate between different computers, routers, 
and websites. IP addresses provide a way of doing so and form an essential part of how the internet works.