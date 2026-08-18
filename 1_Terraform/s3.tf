# this is s3 bucket
resource "aws_s3_bucket" "gp-st-13-devops-buc" {
  bucket = "gp-st-13-devops-buc"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}