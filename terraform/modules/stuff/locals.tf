locals {
  base_group_name  = var.group_name == null ? random_pet.rando.id : var.group_name
  base_policy_name = var.policy_name == null ? random_pet.rando.id : var.policy_name
  base_role_name   = var.role_name == null ? random_pet.rando.id : var.role_name
  base_user_name   = var.user_name == null ? random_pet.rando.id : var.user_name
  group_name       = "${local.app}-${local.base_group_name}"
  policy_name      = "${local.app}-${local.base_policy_name}"
  role_name        = "${local.app}-${local.base_role_name}"
  user_name        = "${local.app}-${local.base_user_name}"
}
