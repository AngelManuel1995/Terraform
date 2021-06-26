output "instance_ip" {
  value = aws_instance.ag-instance.*.public_ip
}