output "api_endpoint" {
  description = "Full URL to use in your curl commands (Step 6)"
  value       = "${aws_apigatewayv2_stage.default.invoke_url}/${var.function_name}"
}

output "dynamodb_table" {
  value = aws_dynamodb_table.notes.name
}

output "lambda_function" {
  value = aws_lambda_function.notes.function_name
}

output "cloudwatch_log_group" {
  value = aws_cloudwatch_log_group.lambda.name
}
