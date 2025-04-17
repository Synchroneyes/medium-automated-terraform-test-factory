resource "aws_iam_policy" "dynamodb_access_policy" {
  name   = "DynamoDBAccessPolicy"
  policy = data.aws_iam_policy_document.iam_access_dynamodb_module_report_table.json
}

resource "aws_iam_role_policy_attachment" "dynamodb_access" {
  role       = aws_iam_role.register_module_result_role.name
  policy_arn = aws_iam_policy.dynamodb_access_policy.arn
}

resource "aws_iam_role" "register_module_result_role" {
  name               = "register_module_result_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource "aws_iam_role_policy_attachment" "register_module_role_policy_attachment" {
  role       = aws_iam_role.register_module_result_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role" "generate_module_report_role" {
  name               = "generate_module_report_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource "aws_iam_role_policy_attachment" "register_module_result_role_policy_attachment" {
  role       = aws_iam_role.generate_module_report_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "dynamodb_access_report" {
  role       = aws_iam_role.generate_module_report_role.name
  policy_arn = aws_iam_policy.dynamodb_access_policy.arn
}

resource "aws_iam_policy" "sns_publish_policy" {
  name   = "SNSPublishPolicy"
  policy = data.aws_iam_policy_document.iam_access_sns_publish.json
}

resource "aws_iam_role_policy_attachment" "sns_publish" {
  role       = aws_iam_role.generate_module_report_role.name
  policy_arn = aws_iam_policy.sns_publish_policy.arn
}
