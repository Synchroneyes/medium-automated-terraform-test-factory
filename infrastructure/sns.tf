resource "aws_sns_topic" "report_topic" {
  name = local.sns_module_report_topic
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.report_topic.arn
  protocol  = "email"
  endpoint  = local.ses_email_destination
}

