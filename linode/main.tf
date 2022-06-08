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
    token = var.api_token
}


# Setup the ssh key from the local machine
#obs: if you run: terraform destroy this ssh key will also be deleted
#resource "linode_sshkey" "mykey" {
#  label = "My-SSH-key"
#  ssh_key = chomp(file(var.public_key_location))
#}

data "linode_sshkey" "mykey" {
  label = "JCASUS"
}

resource "linode_instance" "my_linode_instance" {
    label = "Linode-Instance-Server"
    image = "linode/debian11"
    region = var.region
    type = var.instance_type

    #authorized_keys = [linode_sshkey.mykey.ssh_key] #create ssh_key using resource
    authorized_keys = [data.linode_sshkey.mykey.ssh_key] #uses data ssh_key from linode website

    # Leave the root password unset to keep it random
    root_pass = var.root_pass
  
    connection {
        host = self.ip_address
        user = "root"
        type = "ssh"
        timeout = "2m"
    }
  
    provisioner "remote-exec" {
        inline = [
        "export PATH=$PATH:/usr/bin",
        "sudo apt update",
        
        #install nginx
        "sudo apt install -y nginx"
        ]
    }

#provisioner "file" {
#    source      = "setup_script.sh"
#    destination = "/tmp/setup_script.sh"
#}

#provisioner "remote-exec" {
#    inline = [
#    "chmod +x /tmp/setup_script.sh",
#    "/tmp/setup_script.sh",
#    ]
#}

}