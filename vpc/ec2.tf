resource "aws_instance" "gophish" {
    ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t2.micro"
    # VPC
    subnet_id = "${aws_subnet.prod-subnet-public-1.id}"
    # Security Group
    vpc_security_group_ids = ["${aws_security_group.ssh-https-allowed.id}"]
    # the Public SSH key
    key_name = "${aws_key_pair.local-key.id}"

    user_data = file("${path.module}/install.sh")


    tags = {
        Name = "gophish"
    }
}

// Sends your public key to the instance
resource "aws_key_pair" "local-key" {
  key_name   = "local-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCmLkq3BdHDBMZtC/dMA6lf3rfv9+wX/z/xnfQSbvoVFQV49hw/4dZ1HsQHy0yFUXe4VPbqb/IsTwGKZzzYDvWVRDxnv5qz5U4MsZnG1ouyOnC38Jvi3W9DeLm9FdTatZQMccJ/ZU5MI0Ugj0pozM6LN4l7MQby7XDPdR+c78XMg2XdbT/gFl5F039a0TnK+7Kxg51KdhgakVqi8GDNeiOA++lZlgjPK0Go1pRwnJ3CjuYrG1JBc79LW2nVvgQPMPHrzEcr02QoJj+JnYmCuN7+vwksW6WaQSPcoFKVLw5nbueEISzSVx+GcIJH1iz5mlwKo6pklkMfJeaNHBqJdW0r8ld7GqZbf90hGPjlHG2gqAFKd6HhXrvAvkE5hQFMudB/tEmfVFojFwZnQlML3ewT9h8ix0PkWOWN8XOgZNNySUbiOD9F5NVpf488p9c38hESPlKo9FWeO+R0bcOrfxtef2rMKE/t0Jj+tATDybsweJgzPvCIQIu17h8nGx+IhCs="
}