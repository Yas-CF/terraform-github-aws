resource "aws_cloudwatch_log_group" "ec2_logs" {
  name = "/aws/ec2/${var.instance_name}"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_stream" "ec2_log_stream" {
  name           = "${var.instance_name}-stream"
  log_group_name = aws_cloudwatch_log_group.ec2_logs.name
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "HighCPUUsage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = var.cpu_threshold
  alarm_description   = "This alarm monitors high CPU usage on EC2 instances."
  actions_enabled     = true
  alarm_actions       = [var.topic_arn]
}
resource "aws_cloudwatch_metric_alarm" "disk_alarm" {
  alarm_name          = "LowDiskSpace"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = 60
  statistic           = "Average"
  threshold           = var.disk_threshold
  alarm_description   = "Alarm for low disk space"
  alarm_actions       = [var.topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
  alarm_name          = "HighMemoryUsage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = 60
  statistic           = "Average"
  threshold           = var.memory_threshold
  alarm_description   = "Alarm for high memory usage"
  alarm_actions       = [var.topic_arn]
}