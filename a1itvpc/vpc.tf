# output "zone" {
#     //value = "${length(data.aws_availability_zones.westzone.names)}"
#   value = "${element(data.aws_availability_zones.westzone.names,1)}"
# }

resource "aws_vpc" "v21qw1" {
    count                   = var.env == "albert" || var.accounts == "kick" ? 1 : 0
    cidr_block              = each.value.cidr_block_w
    enable_dns_support      = "true"
    enable_dns_hostnames    = "true"
    tags = {
         Name = "v21qw1"
    }
}
resource "aws_vpc" "v21qe1" {
    count                   = var.env == "albert" || var.accounts == "kick" ? 1 : 0
    provider                = aws.us-east
    cidr_block              = each.value.cidr_block_e
    enable_dns_support      = "true"
    enable_dns_hostnames    = "true"
    tags = {
         Name = "v21qe1"
    }
}

# resource "aws_subnet" "westwebsub" {
#     for_each                = var.accounts  == "albert" || var.accounts == "kick" ? 1 : 0
#     count                   = "${length(data.aws_availability_zones.westzone.names)}"
#     vpc_id                  = aws_vpc.v21qw1[each.key].id
#     provider                = aws.us-west
#     cidr_block              = "10.64.${count.index}.0/24"
#     map_public_ip_on_launch = "true"
#     availability_zone       = "${element(data.aws_availability_zones.westzone.names,count.index)}"

#     tags = {
#          Name = "public-${element(data.aws_availability_zones.westzone.names, count.index)}"
#     }
# }


# resource "aws_subnet" "westwebsub2" {
#     for_each                = var.accounts  == "albert" || var.accounts == "kick" ? 0 : 1
#     count                   = "${length(data.aws_availability_zones.westzone.names)}"
#     vpc_id                  = aws_vpc.v21qw1[each.key].id
#     provider                = aws.us-west
#     cidr_block              = "10.80.${count.index}.0/24"
#     map_public_ip_on_launch = "true"
#     availability_zone       = "${element(data.aws_availability_zones.westzone.names,count.index)}"

#     tags = {
#          Name = "public-${element(data.aws_availability_zones.westzone.names, count.index)}"
#     }
# }

# resource "aws_subnet" "eastwebsub" {
#     for_each                = var.accounts  == "albert" || var.accounts == "kick" ? 1 : 0
#     count = "${length(data.aws_availability_zones.eastzone.names)}"
#     vpc_id = aws_vpc.v21qe1.id
#     provider = aws.us-east
#     cidr_block = "10.128.${count.index}.0/24"
#     map_public_ip_on_launch = "true"
#     availability_zone = "${element(data.aws_availability_zones.eastzone.names,count.index)}"

#     tags = {
#          Name = "public-${element(data.aws_availability_zones.eastzone.names, count.index)}"
#     }
# }


# resource "aws_internet_gateway" "aws2021westgateway" {
#     provider = aws.us-west
#     vpc_id = aws_vpc.v21qw1.id
#     tags = {
#         Name = "aws2021 west gateway"
#     } 
# }


# resource "aws_route_table" "aws2021westdefaultgw" {
#     provider = aws.us-west
#     vpc_id = aws_vpc.v21qw1.id
#     route {
#         cidr_block = "0.0.0.0/0"
#         gateway_id = aws_internet_gateway.aws2021westgateway.id
#     }
#     tags = {
#       Name = "aws2021 west default gateway"
#     }
  
# }

# resource "aws_route_table_association" "aws2021asnw1a" {
#     provider = aws.us-west
#     count = "${length(data.aws_availability_zones.westzone.names)}"
#     subnet_id = aws_subnet.westwebsub[count.index].id
#     route_table_id = aws_route_table.aws2021westdefaultgw.id
  
# }
