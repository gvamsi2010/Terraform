
# Define provider and AWS region
provider "aws" {
  region = var.aws_region
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
}

# Create a public subnet within the VPC
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_block
  map_public_ip_on_launch = true
}

# Create an internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

# Attach the internet gateway to the VPC
resource "aws_vpc_attachment" "gw_attach" {
  vpc_id       = aws_vpc.main.id
  internet_gateway_id = aws_internet_gateway.gw.id
}

# Create security group allowing inbound traffic on port 80
resource "aws_security_group" "web" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch EC2 instance
resource "aws_instance" "example" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.public.id
  security_groups = [aws_security_group.web.name]
  tags = {
    Name = var.instance_name
  }

  # Provisioners for deploying Python web app
  provisioner "file" {
    source      = var.app_source_path
    destination = var.app_destination_path
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install python3 -y",
      "sudo python3 ${var.app_destination_path} &"
    ]
  }
}

# Output the public IP address of the instance
output "instance_public_ip" {
  value = aws_instance.example.public_ip
}