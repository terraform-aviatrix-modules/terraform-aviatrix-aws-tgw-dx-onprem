# terraform-aviatrix-aws-tgw-dx-onprem

### Description
This module uses AWS TGW, DXGW and Transit VIF to integrate Aviatrix transit to on-prem over DX without overlay.

### Diagram
<img src="https://github.com/terraform-aviatrix-modules/terraform-aviatrix-aws-tgw-dx-onprem/blob/main/img/diagram.png?raw=true">

### Compatibility
Module version | Terraform version | Controller version | Terraform provider version
:--- | :--- | :--- | :---
v1.0.0 | v0.13 - v1.x | >=6.5 | >=2.20.3

### Usage Example

Existing DXGW:
```
module "eu-west-1" {
  source  = "terraform-aviatrix-modules/aws-tgw-dx-onprem/aviatrix"
  version = "1.0.0"

  dx_gateway_id  = "xxxxxxxxx-xxxx-xxxx-xxxxxxxxxx"
  allowed_prefix = "10.100.0.0/16, 172.18.0.0/23"
  region         = "eu-west-1"
  account        = "AWS"
  transit_gw     = aviatrix_transit_gateway.my_transit
}
```

New DXGW + Transit VIF:
```
module "eu-west-1" {
  source  = "terraform-aviatrix-modules/aws-tgw-dx-onprem/aviatrix"
  version = "1.0.0"

  allowed_prefix = "10.100.0.0/16, 172.18.0.0/23"
  region         = "eu-west-1"
  account        = "AWS"
  transit_gw     = aviatrix_transit_gateway.my_transit

  vlan              = 300
  onprem_asn        = 65500
  aws_dx_connection = "xxxxxxxxx-xxxx-xxxx-xxxxxxxxxx"
}
```

### Variables
The following variables are required:

key | value
:--- | :---
account | The AWS account name, as known by the Aviatrix controller
allowed_prefix | A list of prefixes to be announced to on-prem from the TGW
aws_asn | AS Number to be used to TGW
aws_dx_connection | AWS DX Circuit ID. Not required when existing DXGW is used with dx_gateway_id.
onprem_asn | AS Number for on-premise customer router. Not required when existing DXGW is used with dx_gateway_id.
transit_gw | Aviatrix Transit Gateway object with all attributes
vlan | VLAN ID for the transit VIF. Not required when existing DXGW is used with dx_gateway_id.

The following variables are optional:

key | default | value 
:---|:---|:---
dx_gateway_id | \<newly created> | ID of the Direct Connect Gateway
name | tgw_\<region> <br> dxgw_\<region> <br> transit_vif_\<region> | Name for TGW/DXGW/VIF

### Outputs
This module will return the following outputs:

key | description
:---|:---
\<keyname> | \<description of object that will be returned in this output>
