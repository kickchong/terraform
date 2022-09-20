data "aws_availability_zones" "westzone" {
    provider = aws.us-west

}
data "aws_availability_zones" "eastzone" {
    provider = aws.us-east
}

