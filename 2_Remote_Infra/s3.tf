resource "aws_s3_bucket" "remote_s3" {
  bucket = "st-13-remote-infra-statefile-bucket-112"

  tags = {
    Name        = "st-13-remote-infra-statefile-bucket-112"
    Environment = "Dev"
  }
}