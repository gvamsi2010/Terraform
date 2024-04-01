# terraform.tfvars

aws_region            = "us-east-1"
vpc_cidr_block       = "10.0.0.0/16"
subnet_cidr_block    = "10.0.1.0/24"
ami_id               = "ami-12345678"
instance_type        = "t2.micro"
instance_name        = "test instance"
app_source_path      = "./app.py"
app_destination_path = "/home/ec2-user/app.py"