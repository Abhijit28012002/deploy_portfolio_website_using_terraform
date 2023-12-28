# How to use aws cloud by TF
terraform {
  required_providers {
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}



# Step : Launch AWS Instance
resource "aws_instance" "my_newInstance" {
  ami             = "ami-08fe36427228eddc4"  # Replace with your desired AMI
  instance_type   = "t2.micro"              # Replace with your desired instance type
  key_name        = "wordpressKey"
  vpc_security_group_ids = [ "sg-06080a1d14038b549" ]
  tags = {
    Name = "MyPortfolioWebserver"
  }
  # Step 4: Pull GitHub Flask Code and Run It
  connection {
    type        = "ssh"
    user        = "ec2-user"  # replace with your SSH username
    private_key = file("E:/TerraformWorkout/wordpressKey.pem")  # replace with your private key path
    host        = self.public_ip
  }

  # Use remote-exec to upload web server files
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install python3-pip -y",
      "sudo yum install git -y",
      "sudo git clone https://github.com/Abhijit28012002/deploy_portfolio_website_using_terraform.git  /home/ec2-user/flask-app",
      "sudo pip3 install -r ./flask-app/requirements.txt",
      "sudo python3 ./flask-app/app.py"
    ]
  }
}

  



















   
