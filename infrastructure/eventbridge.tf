resource "aws_cloudwatch_event_rule" "lambda_trigger" {
  name                = "scheduler-generate-module-report"
  description         = "Trigger Lambda function to generate module report"
  schedule_expression = "cron(0 4 * * ? *)"
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule = aws_cloudwatch_event_rule.lambda_trigger.name
  arn  = aws_lambda_function.generate_module_report.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.generate_module_report.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_trigger.arn
}
