data "aws_availability_zones" "westzone" {
    provider = aws.us-west-1

}
data "aws_availability_zones" "eastzone" {
    provider = aws.us-east-1
}

