resource "aws_instance" "code_deploy_ec2" {
  ami           = "ami-0d4c3eabb9e72650a"
  instance_type = "t2.micro"

  tags = {
    Name = "CodeDeployEc2"
  }
}


