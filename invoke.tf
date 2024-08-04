resource "aws_lambda_permission" "allow_s3_invoke" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_file_mover.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.frogtech-us-external.arn
}


resource "aws_s3_bucket_notification" "frogtech-us-external_notification" {
  depends_on = [aws_lambda_function.s3_file_mover]
  bucket     = aws_s3_bucket.frogtech-us-external.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_file_mover.arn
    events              = ["s3:ObjectCreated:*"]   
    filter_suffix = ".txt"  

  }
}
