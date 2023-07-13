resource "aws_dynamodb_table" "received_messages" {
  name           = "received_messages"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "phone_number"
  range_key      = "message_id"

  attribute {
    name = "phone_number"
    type = "S"
  }

  attribute {
    name = "message_id"
    type = "S"
  }

#   attribute {
#     name = "message"
#     type = "S"
#   }

#   attribute {
#     name = "last_sent_time"
#     type = "S"
#   }
# }
}