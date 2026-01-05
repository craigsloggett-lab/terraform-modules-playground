locals {
  # Resource naming with defaults
  launch_template_name = var.launch_template_name != null ? var.launch_template_name : "${var.identifier}-lt"
  asg_name             = var.asg_name != null ? var.asg_name : "${var.identifier}-asg"
  security_group_name  = var.security_group_name != null ? var.security_group_name : "${var.identifier}-sg"

  # User data handling
  user_data_base64 = var.user_data != null ? base64encode(var.user_data) : (
    var.user_data_base64 != null ? var.user_data_base64 : null
  )
}
