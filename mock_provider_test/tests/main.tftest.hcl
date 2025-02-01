mock_provider "aws" {
    mock_ignore = ["data.aws_iam_policy"]
}

run "test" {
  assert {
    condition     = can(jsonencode(data.aws_iam_policy_document.this.json)["Version"])
    error_message = "Json should be populated since mock is ignored"
  }
}