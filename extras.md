### ASSUMEROLE POLICY

- This returns a set of temporary security credentials that one can use to access AWS resources that you might not normally have access to. 
- These temporary credentials consist of an access key ID, a secret access key, and a security token. 
- AssumeRole can be used within one's account or for cross-account access. 
- The temporary security credentials created by AssumeRole can be used to make API calls to any AWS service with the following exception: 
- You cannot call the AWS STS GetFederationToken or GetSessionToken API operations.

### ROLE POLICY
IAM Roles manage who has access to your AWS resources, whereas IAM policies control their permissions. 
A Role with no Policy attached to it won't have to access any AWS resources.
The difference between IAM roles and policies in AWS is that a role is a type of IAM identity that 
can be authenticated and authorized to utilize an AWS resource, whereas a policy defines the permissions of the IAM identity.

### IP ADDRESS 
An IP address is a unique address that identifies a device on the internet or a local network. IP stands for "Internet Protocol," 
which is the set of rules governing the format of data sent via the internet or local network.

In essence, IP addresses are the identifier that allows information to be sent between devices on a network: they contain location 
information and make devices accessible for communication. The internet needs a way to differentiate between different computers, routers, 
and websites. IP addresses provide a way of doing so and form an essential part of how the internet works.

### SUBNETS
A subnet is a range of IP addresses in your VPC. You can launch AWS resources into a specified subnet. Use a public subnet for resources 
that must be connected to the internet, and a private subnet for resources that won't be connected to the internet.

To protect the AWS resources in each subnet, you can use multiple layers of security, including security groups and network access control lists (ACL).

### CIDR NOTATION
CIDR notation compactly indicates the network mask for an address and adds on the total number of bits in the entire address using slash notation.

### Internet Gateway

Internet Gateway (IGW) is a horizontally scaled, redundant, and highly available VPC component that allows communication between your VPC and the internet.
Internet Gateway enables resources (like EC2 instances) in public subnets to connect to the internet. Similarly, resources on the internet can initiate a connection to resources in your subnet using the public.
If a VPC does not have an Internet Gateway, then the resources in the VPC cannot be accessed from the Internet (unless the traffic flows via a Corporate Network and VPN/Direct Connect).
Internet Gateway supports IPv4 and IPv6 traffic.
Internet Gateway does not cause availability risks or bandwidth constraints on your network traffic.

In order to make subnet public, add a route to your subnet’s route table that directs internet-bound traffic to the internet gateway.
You can associate exactly one Internet Gateway with a VPC.
Internet Gateway is not Availability Zone specific.
There’s no additional charge for having an internet gateway in your account.

### NAT Gateway
NAT Gateway (NGW) is a managed Network Address Translation (NAT) service.
NAT Gateway does something similar to Internet Gateway (IGW), but it only works one way: 
Instances in a private subnet can connect to services outside your VPC but external services cannot initiate a connection with those instances.
NAT gateways are supported for IPv4 or IPv6 traffic.
NAT gateway supports the following protocols: TCP, UDP, and ICMP.
Each NAT gateway is created in a specific Availability Zone and implemented with redundancy in that zone.
If you have resources in multiple Availability Zones and they share one NAT gateway, and if the NAT gateway’s Availability Zone is down, resources in the other Availability Zones lose internet access.
To create an Availability Zone-independent architecture, create a NAT gateway in each Availability Zone.
You can associate exactly one Elastic IP address with a public NAT gateway.
You are charged for each hour that your NAT gateway is available and each Gigabyte of data that it processes.