# this is s3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}