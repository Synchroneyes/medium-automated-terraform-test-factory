data "archive_file" "generate_module_report" {
  type        = "zip"
  source_file = "${path.module}/code/generate_module_report/generate_module_report.py"
  output_path = "${path.module}/build/generate_module_report.zip"
}

resource "aws_lambda_function" "generate_module_report" {
  filename      = "${path.module}/build/generate_module_report.zip"
  function_name = "generate_module_report"
  role          = aws_iam_role.generate_module_report_role.arn
  handler       = "generate_module_report.handler"

  source_code_hash = data.archive_file.generate_module_report.output_base64sha256

  runtime = "python3.12"

  environment {
    variables = {
      DYNAMODB_TABLE_NAME = aws_dynamodb_table.module_report_table.name
      SNS_TOPIC_ARN       = aws_sns_topic.report_topic.arn
      EMAIL_SUBJECT       = "Module Report"

    }
  }
}
