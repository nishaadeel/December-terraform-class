variable "tags" {
  description = "Please provide a map of tags for each resource"
  type = map(any)
  default = {
    Env = "dev"
  }
}

variable "region" {
  description = "Please provide a region"
}

variable "key_name1" {
  description = "Please provide a key name for first one"
}

variable "key_name2" {
  description = "Please provide a key name for second one"
}

variable "public_key" {
  description = "Please provide a key location"
}

variable vpc_cidr_block {}
variable public_subnet_1_cidr_block {}
variable public_subnet_2_cidr_block {}
variable public_subnet_3_cidr_block {}
