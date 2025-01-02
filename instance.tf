resource "aws_instance" "web-server" {
    ami = "ami-06e46074ae430fba6"
    instance_type = "t2.micro"
    count = 2
    security_groups = ["${aws_security_group.web-server.name}"]
    user_data = <<-EOF

        #!/bin/bash
        sudo su
        yum update -y
        yum install httpd -y
        systemctl start httpd
        systemctl enable httpd
        echo "<html><h1> This is a sample ELB Server. Thank You for Visiting $(hostmame -f)...</p> </h1
        EOF
    
    tags = {
        Name = "alb-ec2"
    }
}
