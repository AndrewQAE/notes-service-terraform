variable "aws_region" {
  description = "AWS region to deploy into (the PDF uses eu-west-2 / London)"
  type        = string
  default     = "eu-west-2"
}

variable "aws_profile" {
  description = "AWS CLI profile to use (from ~/.aws/credentials)"
  type        = string
  default     = "default"
}

variable "function_name" {
  description = "Lambda function name (Step 2)"
  type        = string
  default     = "notes-service"
}

variable "table_name" {
  description = "DynamoDB table name (Step 1)"
  type        = string
  default     = "Notes"
}

variable "lambda_runtime" {
  description = "Python runtime for Lambda (Step 2)"
  type        = string
  default     = "python3.14"
}

variable "api_stage_name" {
  description = "API Gateway stage name. 'default' matches the URL in the PDF."
  type        = string
  default     = "default"
}

variable "log_retention_days" {
  description = "How long to keep CloudWatch logs"
  type        = number
  default     = 14
}
