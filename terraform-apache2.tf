#declare the provider here as i am using single terraform file all the prerequisites here
provider "aws" {
#region where you want to make your server
  region     = "ap-south-1"
#access should be created in identity and access management console
  access_key = "AKIA6FAKQXM47WJWY2OK"
  secret_key = "+Y9Hw/YCEprcl3C5Tk5gIPars7ZcIQM1tnnWtT27"

}
#name of the resource that have been created
resource "aws_instance" "myfirsttec2" {
#ami is for ubuntu
  ami                    = "ami-0123b531fc646552f"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name               = "terraform-key"

  user_data = <<-EOF
           #!/bin/bash
           sudo apt-get update
           sudo apt install apache2 -y
EOF
  tags = {
    Name = "terraform-mynewserver"



 }
}

 

resource "aws_security_group" "instance" {
  name = "terraform-security-group"

  #inbound HTTP from anywhere

  ingress {
    from_port   = 80
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value = aws_instance.myfirsttec2.public_ip
}

output "id" {
  value = aws_instance.myfirsttec2.id
}

output "public_dns" {
  value = aws_instance.myfirsttec2.public_dns
}

output "security_groups" {
  value = aws_instance.myfirsttec2.security_groups
}

output "subnet_id" {
  value = aws_instance.myfirsttec2.subnet_id
}

output "VPC_security_group" {
  value = aws_instance.myfirsttec2.vpc_security_group_ids
}

