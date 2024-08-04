resource "aws_s3_bucket" "frogtech-us-external" {

   bucket = "bucketone123456s"
   force_destroy = true
   object_lock_enabled = false
   tags = {
    Name        = "frogtech-us-external"
    Environment = "${var.environment}"
  }
}


resource "aws_s3_bucket" "frogtech-us-internal" {

   bucket = "buckettwo123456s"
   force_destroy = true
   object_lock_enabled = false
   tags = {
    Name        = "frogtech-us-internal"
    Environment = "${var.environment}"
  }
}


