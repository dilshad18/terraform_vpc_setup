resource "aws_vpc" "vpc" {
        cidr_block = "10.218.32.0/20"
        tags {
         Name      = "qa-vpc"
        }
}

resource "aws_internet_gateway" "vpc_gateway" {
        vpc_id    = "${aws_vpc.vpc.id}"
        tags {
         Name     = "vpc_igw"
        }
}
