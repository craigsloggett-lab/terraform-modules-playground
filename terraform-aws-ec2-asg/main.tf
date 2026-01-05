
# Launch Template
resource "aws_launch_template" "this" {
  name                   = local.launch_template_name
  image_id               = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.aws_key_pair_name
  update_default_version = true
  user_data              = local.user_data_base64
  ebs_optimized          = var.ebs_optimized

  monitoring {
    enabled = var.enable_monitoring
  }

  iam_instance_profile {
    arn = var.iam_instance_profile_arn
  }

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    security_groups             = [aws_security_group.instances.id]
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_type           = var.root_volume_type
      volume_size           = var.root_volume_size
      iops                  = contains(["io1", "io2", "gp3"], var.root_volume_type) ? var.root_volume_iops : null
      throughput            = var.root_volume_type == "gp3" ? var.root_volume_throughput : null
      encrypted             = true
      delete_on_termination = var.delete_on_termination
    }
  }

  metadata_options {
    http_endpoint               = var.http_endpoint
    http_tokens                 = var.http_tokens
    http_put_response_hop_limit = var.http_put_response_hop_limit
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.identifier}-host"
    }
  }

  tag_specifications {
    resource_type = "volume"

    tags = {
      Name = "${var.identifier}-volume"
    }
  }

  tags = {
    Name = local.launch_template_name
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "this" {
  name                      = local.asg_name
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity != null ? var.desired_capacity : var.min_size
  vpc_zone_identifier       = var.subnet_ids
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  default_cooldown          = var.default_cooldown
  termination_policies      = var.termination_policies
  enabled_metrics           = var.enabled_metrics
  metrics_granularity       = var.metrics_granularity
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  protect_from_scale_in     = var.protect_from_scale_in

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  target_group_arns = var.target_group_arns
}
