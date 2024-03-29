output "arn" {
  description = "ARN of the DynamoDB table."
  value       = try(aws_dynamodb_table.main.arn, null)
}
