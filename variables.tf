variable "name" {
  description = "Name for TGW"
  type        = string
  default     = ""
}

variable "transit_gw" {
  description = "Transit Gateway object with all attributes"
}

variable "account" {
  description = "The AWS account name, as known by the Aviatrix controller"
  type        = string
}

variable "dx_gateway_id" {
  description = "ID of the Direct Connect Gateway"
  type        = string
}

variable "allowed_prefix" {
  description = "A list of prefixes to be announced to on-prem from the TGW"
  type        = string
}

variable "aws_asn" {
  description = "AS Number to be used to TGW"
  type        = number
}

variable "region" {
  description = "AWS Region in which this module is deployed"
  type        = string
}