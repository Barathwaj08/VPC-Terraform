#Creating Security Groups

/*resource "aws_security_group" "security_group" {
    description = "Allow limited inbound external traffic"
    vpc_id      = "${aws_vpc.dev_vpc.id}"
    name        = "terraform_ec2_private_sg"


    ingress {
        protocol       = "tcp"
        cidr_blocks    = ["0.0.0.0/0"]
        from_port      = 22
        to_port        = 22
    }

    ingress {
        protocol       = "tcp"
        cidr_blocks    = ["0.0.0.0/0"]
        from_port      = 80
        to_port        = 80
    }

    ingress {
        protocol       = "tcp"
        cidr_blocks    = ["0.0.0.0/0"]
        from_port      = 443
        to_port        = 443
    }

    egress {
        protocol       = -1
        cidr_blocks    = ["0.0.0.0/0"]
        from_port      = 0
        to_port        = 0
    }

    tags = {
        Name = "ec2-private-sg"
    }
}

output "aws_security_gr_id" {
    value = "${aws_security_group.security_group.id}"
}

#creating EC2 in public subnet
resource "aws_instance" "public_instance" {
    ami = "ami-0574da719dca65348"
    instance_type = "t2.micro"
    vpc_security_group_ids =  [ "${aws_security_group.security_group.id}" ]
    subnet_id = "${aws_subnet.public_subnet.id}"
    key_name = "newkey"
    count = 1
    associate_public_ip_address = true
    tags = {
        Name = "public_instance"
    }
}

#creating EC2 in private subnet
resource "aws_instance" "private_instance" {
    ami = "ami-0b8c6b923777519db"
    instance_type = "t3.small"
    vpc_security_group_ids = [ "${aws_security_group.security_group.id}" ]
    subnet_id = "${aws_subnet.private_subnet.id}"
    key_name = "newkey"
    count = 3
    associate_public_ip_address = false
    tags = {
        Name = "private_instance"
    }
 }

 resource "tls_private_key" "key_pair" {

  algorithm = "RSA"

  rsa_bits  = 4096

}



resource "aws_key_pair" "key_pair" {

  key_name   = "newkey" # Create a "newkey" to AWS!!

  public_key = tls_private_key.key_pair.public_key_openssh

}



resource "local_file" "ssh_key" {

  filename = "${aws_key_pair.key_pair.key_name}.pem"

  content  = tls_private_key.key_pair.private_key_pem

}
*/