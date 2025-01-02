# Creating Nat Gateway
resource "aws_eip" "nat" {
  domain = "vpc"
}
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet.id
  depends_on    = [aws_internet_gateway.dev-gw]
}
# Add routes for VPC
resource "aws_route_table" "dev-private" {
  vpc_id = aws_vpc.dev_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }
  tags = {
    Name = "dev-private"
  }
}
# Creating route associations for private Subnets
resource "aws_route_table_association" "dev-private" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.dev-private.id
}