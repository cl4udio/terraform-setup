variable "api_token" {
    default = "YOUR_API_TOKEN"
}

variable "public_key_location" {
    default = "~/.ssh/id_rsa.pub"
    type    = string
}

variable "root_pass" {
    default = "YOUR_PASSWORD"
}

variable "region" {
    default = "us-central"
    type    = string
}

variable instance_type {
    default = "g6-nanode-1"
    type    = string
}