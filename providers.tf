provider "aws" {
  #Disabling credential validation to deal with use case where no AWS resources need to be deployed (dx_gateway_id is provided) and AWS credentials are not set up.
  skip_credentials_validation = true
  skip_region_validation      = true
  skip_requesting_account_id  = true
}
