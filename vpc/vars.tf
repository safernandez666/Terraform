variable "AWS_REGION" {    
    default = "us-east-1"
}

variable "AMI" {
    type = map

    default = {
        us-east-1 = "ami-0747bdcabd34c712a"
    }
}