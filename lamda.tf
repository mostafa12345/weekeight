resource "aws_lambda_layer_version" "object_migration_layer" {
  s3_bucket = "testasdawf4115154"
  s3_key    = "my_lambda_function.zip"

  layer_name          = "objectMigrationLayer"
  compatible_runtimes = ["python3.12"]
}

resource "aws_lambda_function" "s3_file_mover" {
  function_name    = "frogtech_s3_file_mover"
  s3_bucket        = "testasdawf4115154"
  s3_key           = "my_lambda_function.zip"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.12"
  role             = aws_iam_role.lambda_role.arn
  layers           = [aws_lambda_layer_version.object_migration_layer.arn]

  environment {
    variables = {
      SOURCE_BUCKET      = "frogtech-us-external"
      DESTINATION_BUCKET = "frogtech-us-internal"
    }
  }
  tags = {
    Environment = "${var.environment}"
  }
}

