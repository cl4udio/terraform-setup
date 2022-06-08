terraform {
    required_version = ">1.0.0"
    required_providers {
        linode = {
            source = "linode/linode"
            version = "1.27.2"
        }
    }
}

provider "linode" {
    token = "token"
}

resource "linode_instance" "example_label" {}
