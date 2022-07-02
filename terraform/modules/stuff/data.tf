data "aws_iam_policy_document" "policy_doc" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
  }
}
