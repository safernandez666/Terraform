resource "aws_instance" "gophish" {
    ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t2.micro"
    # VPC
    subnet_id = "${aws_subnet.prod-subnet-public-1.id}"
    # Security Group
    vpc_security_group_ids = ["${aws_security_group.ssh-https-allowed.id}"]
    # the Public SSH key
    key_name = "${aws_key_pair.local-key.id}"
    tags = {
        Name = "gophish"
    }
}

// Sends your public key to the instance
resource "aws_key_pair" "local-key" {
  key_name   = "local-key"
  public_key = "XXX"
}