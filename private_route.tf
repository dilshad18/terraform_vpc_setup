resource "aws_subnet" "subnets" {
  count             = "${length(var.vpc_subnet_ips)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${element(var.vpc_subnet_ips, count.index)}"
  availability_zone = "${element(var.vpc_subnet_azs, count.index)}"

  tags {
    Name = "${element(var.vpc_subnet_names, count.index)}"
  }
}

resource "aws_eip" "nat" {
      vpc      = true
      tags {
       Name    = "NAT_GW"
        }
}
resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${element(aws_subnet.pub_subnets.*.id, count.index)}"
}

resource "aws_default_route_table" "default_route" {
  default_route_table_id = "${aws_vpc.vpc.default_route_table_id}"
  tags {
                    Name = "private_route"
        }
}
resource "aws_route_table_association" "subnets" {
  count          = "${length(var.vpc_subnet_ips)}"
  subnet_id      = "${element(aws_subnet.subnets.*.id, count.index)}"
  route_table_id = "${aws_default_route_table.default_route.id}"
}
resource "aws_route" "private_route" {
  route_table_id         = "${aws_default_route_table.default_route.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.gw.id}"
}
