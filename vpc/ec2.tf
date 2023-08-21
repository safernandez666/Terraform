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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCfMzKjPyO/ZVNs9fiH9LUEVvmvaKuRba8b8UZ3q5LspR2d4Nsr4gP0+l0TfHF4/kvT0ImwNmylh+xW2bDxby+QNLI6b6F9fdFM1C8biqZptHPobYhDgceykCM9eZS71pipFwPi4rq/tE2qszwH0u3EY5TqpdSFFRCYvmtfQtd7q+mXRb+Npesvn5c4oHs7NRdz/1FQxxJWit88KXOxBoBBNXIt75iaQsdL15PhS4KXLYa1DIARHmXuSGFO9eYNQk3V2cRBSVEoyIp6ovQP1g6GGtEHNbJ4sbLW0t6pnYaZC24hkJtIWYbkSRyZ7DFSFpO1IEr1Hl2vgP8mZYBRO8nPNjQcq2TZF4yGB8C2+nhtXuYvF/ZDj+kVovnaQa/v5xqmTu1SqKDOdKFnAq4H/KSogQmb++V89rv1wk6hjz4FUTJ/9zSFQDp7q1NidIhkTYV2MOK/U81uem1Ggurt2OEV1jHV7VXOCQ5cRcjFiSYUED/y6OZykZWWHWw9RTzTp8hdploHie06RaiLVmBdnsGGkFJZB9luhmhEcm2FUqqkcdHZoWoYgl1pzUEda/9khQ0tNkb6CnzZkfGMvYN4EmmXi7Ad7Ewp/jW2QfuPaEosuXdn+RBlM9/5Ns/Y2a6uDws7Cnd4B9TZwo2ol+00STx7bOY49DRjpNXcGoSZRxsg/w== santiago@Santiagos-MBP"
}