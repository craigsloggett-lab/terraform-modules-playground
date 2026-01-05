locals {
  role_name             = var.role_name != null ? var.role_name : "${var.identifier}-role"
  instance_profile_name = var.instance_profile_name != null ? var.instance_profile_name : "${var.identifier}-instance-profile"
}
