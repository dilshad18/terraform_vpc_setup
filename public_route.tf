resource "aws_subnet" "pub_subnets" {
  count             = "${length(var.vpc_pub_subnet_ips)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = "True"
  cidr_block        = "${element(var.vpc_pub_subnet_ips, count.index)}"
  availability_zone = "${element(var.vpc_pub_subnet_azs, count.index)}"

  tags {
    Name = "${element(var.vpc_pub_subnet_names, count.index)}"
  }
}

resource "aws_route_table" "public_route" {
        vpc_id     = "${aws_vpc.vpc.id}"
        route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.vpc_gateway.id}"
        }
        tags {
         Name      = "public_route"
        }
}
resource "aws_route_table_association" "pub_subnets" {
  count          = "${length(var.vpc_pub_subnet_ips)}"
  subnet_id      = "${element(aws_subnet.pub_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_route.id}"
}
