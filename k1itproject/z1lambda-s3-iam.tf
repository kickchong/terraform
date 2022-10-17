resource "aws_s3_bucket" "chonglife" {
    provider = aws.us-west
    bucket = "www.chonglife.com"
}

data "archive_file" "lambda_hello_world" {
    type = "zip"
    source_dir = "${path.module}/hwjs"
    output_path = "${path.module}/hwjs.zip"
  
}

resource "aws_s3_object" "lambda_hello_world" {
    provider = aws.us-west
    bucket = aws_s3_bucket.chonglife.id
    key = "hwjs.zip"
    source = data.archive_file.lambda_hello_world.output_path
    etag = filemd5(data.archive_file.lambda_hello_world.output_path)
  
}


# resource "aws_iam_role" "lambda_exec" {
#     provider = aws.us-west
#     name = "serverless_lambda"
#     assume_role_policy = jsonencode({
#         Version = "2012-10-17"
#         Statement = [{
#             Action = "sts:AssumeRole"
#             Effect = "Allow"
#             Sid    = ""
#             Principal = {
#                 Service = "lambda.amazonaws.com"
#                 }
#             }
#         ]
#     })
# }

# resource "aws_iam_role_policy_attachment" "lambda_policy" {
#     provider = aws.us-west
#     role       = aws_iam_role.lambda_exec.name
#     policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
# }


# resource "aws_lambda_function" "hello_world" {
#     provider = aws.us-west
#     function_name = "HelloWorld"

#     s3_bucket = aws_s3_bucket.chonglife.id
#     s3_key = aws_s3_object.lambda_hello_world.key
#     runtime = "nodejs12.x"
#     handler = "hello.handler"
#     source_code_hash = data.archive_file.lambda_hello_world.output_base64sha256
#     role = aws_iam_role.lambda_exec.arn 

# }

# /*
# resource "aws_cloudwatch_log_group" "hello_world" {
#     provider = aws.us-west
#     name = "/aws/lambda/${aws_lambda_function.hello_world.function_name}"
#     retention_in_days = 30
# }
# */
# output "function_name" {
#     description = "Name of the Lambda function."
#     value = aws_lambda_function.hello_world.function_name
# }
