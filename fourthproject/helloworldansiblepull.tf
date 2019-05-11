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

# Provisioner for applying Ansible playbook in Pull mode
  provisioner "remote-exec" {
    connection {
      user = "ec2-user"
      private_key = "${file("/home/tom/.ssh/EffectiveDevOpsAWS.pem")}"
    }
    inline = [
      "sudo amazon-linux-extras install epel ansible2 -y",
      "sudo yum install -y git",
      "sudo ansible-pull -U https://github.com/yogeshraheja/ansible helloworld.yml -i localhost",
    ]
  }
  
}

# IP address of newly created EC2 instance
output "myserver" {
 value = "${aws_instance.myserver.public_ip}"
}