# Provider Configuration for AWS
provider "aws" {
  region     = "us-west-1"
}

# Resource Configuration for AWS
resource "aws_instance" "myserver" {
  ami = "ami-0019ef04ac50be30f"
  instance_type = "t2.micro"
  key_name = "EffectiveDevOpsAWS"
  vpc_security_group_ids = ["sg-066b20ad2fe8c61da"]
  subnet_id = "subnet-0e48b45ca14fcdb15"

  tags {
    Name = "helloworld"
  }

# Provisioner for applying Ansible playbook
  provisioner "remote-exec" {
    connection {
      user = "ec2-user"
      private_key = "${file("/home/tom/.ssh/EffectiveDevOpsAWS.pem")}"
    }
  }
  
  provisioner "local-exec" {
    command = "sudo echo '${self.public_ip}' > ./myinventory",
  }

  provisioner "local-exec" {
    command = "sudo ansible-playbook -i myinventory --private-key=/home/tom/.ssh/EffectiveDevOpsAWS.pem helloworld.yml",
  }  
}

# IP address of newly created EC2 instance
output "myserver" {
 value = "${aws_instance.myserver.public_ip}"
}