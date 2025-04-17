
data "archive_file" "register_module_result" {
  type        = "zip"
  source_file = "${path.module}/code/register_module_result/register_module_result.py"
  output_path = "${path.module}/build/register_module_result.zip"
}

resource "aws_lambda_function" "register_module_result" {
  filename      = "${path.module}/build/register_module_result.zip"
  function_name = "register_module_result"
  role          = aws_iam_role.register_module_result_role.arn
  handler       = "register_module_result.handler"

  source_code_hash = data.archive_file.register_module_result.output_base64sha256

  runtime = "python3.12"

  environment {
    variables = {
      DYNAMODB_TABLE_NAME = aws_dynamodb_table.module_report_table.name
    }
  }
}
