resource "random_pet" "rando" {}

resource "aws_iam_role" "role" {
  assume_role_policy = aws_iam_policy.policy.arn
}

resource "aws_iam_policy" "policy" {
  name   = local.policy_name
  policy = data.aws_iam_policy_document.policy_doc.json
}

resource "aws_iam_group" "group" {
  name = local.group_name
}

resource "aws_iam_user" "user" {
  name = local.user_name
}

resource "aws_iam_group_membership" "user_group" {
  name  = "${aws_iam_user.user.id}-${aws_iam_group.group.id}"
  group = aws_iam_group.group.id
  users = [aws_iam_user.user.id]
}

resource "aws_iam_group_policy_attachment" "group_policy" {
  group      = aws_iam_group.group.id
  policy_arn = aws_iam_policy.policy.id
}
