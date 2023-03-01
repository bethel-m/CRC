resource "aws_dynamodb_table" "state_locks" {
  name = "bethelmmadu.site-bucket-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}