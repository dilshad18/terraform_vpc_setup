variable "vpc_pub_subnet_ips" {
   type    ="list"
   default = ["10.218.32.0/24", "10.218.33.0/24", "10.218.34.0/24"]
}


variable "vpc_pub_subnet_names" {
   type    ="list"
   default = ["pub-a","pub-b","pub-c"]
}

variable "vpc_pub_subnet_azs" {
       type    = "list"
       default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

}


variable "vpc_subnet_ips" {
    type    ="list"
    default = ["10.218.35.0/24", "10.218.36.0/24", "10.218.37.0/24","10.218.38.0/24","10.218.39.0/24","10.218.40.0/24"]
}

variable "vpc_subnet_names" {
    type   ="list"
   default = ["app-a","app-b", "app-c","srv-b","srv-c","srv-a"]
}


variable "vpc_subnet_azs" {
      type    ="list"
      default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}
