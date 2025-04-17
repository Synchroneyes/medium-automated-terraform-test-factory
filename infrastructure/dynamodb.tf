resource "aws_dynamodb_table" "module_report_table" {
  name         = "ModuleReportTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ModuleName"
  range_key    = "ModuleVersion"

  attribute {
    name = "ModuleName"
    type = "S"
  }

  attribute {
    name = "ModuleVersion"
    type = "S"
  }

  tags = {
    Environment = "production"
    Name        = "ModuleReportTable"
  }
}
