# terraform-aviatrix-aws-tgw-dx-onprem

### Description
This module uses AWS TGW, DXGW and Transit VIF to integrate Aviatrix transit to on-prem over DX without overlay.

### Diagram
\<Provide a diagram of the high level constructs thet will be created by this module>
<img src="<IMG URL>"  height="250">

### Compatibility
Module version | Terraform version | Controller version | Terraform provider version
:--- | :--- | :--- | :---
v1.0.0 | v0.13 - v1.x | >=6.5 | >=2.20.3

### Usage Example
```
module "transit_aws_1" {
  source  = "terraform-aviatrix-modules/aws-transit/aviatrix"
  version = "1.0.0"

  cidr = "10.1.0.0/20"
  region = "eu-west-1"
  aws_account_name = "AWS"
}
```

### Variables
The following variables are required:

key | value
:--- | :---
account | The AWS account name, as known by the Aviatrix controller
dx_gateway_id | ID of the Direct Connect Gateway
allowed_prefix | A list of prefixes to be announced to on-prem from the TGW
aws_asn | AS Number to be used to TGW

The following variables are optional:

key | default | value 
:---|:---|:---
name | tgw_<region> | Name for TGW

### Outputs
This module will return the following outputs:

key | description
:---|:---
\<keyname> | \<description of object that will be returned in this output>
