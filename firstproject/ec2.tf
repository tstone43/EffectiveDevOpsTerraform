# Provider Configuration for AWS
provider "aws" {
  access_key = "<YOUR AWS ACCESS KEY>"
  secret_key = "<YOUR AWS SECRET KEY>"
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
}
