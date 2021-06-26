provider "aws" {
  region="us-east-2"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDFzF7hYdfcr22WvGIbcNPlpAWFeNu8L1G3UEKs1MABnDlq7E4zR9YHLLDZvk8tWnmna6V8+4CVWo6mUZrx8r9c5RDFObMXXdO6I0b3dLozfkHdmKi3bPf5jF1OdUr7op+Zt6iBGNLQ5iwwgfE6eJxGwn8XF0b9w8FqP2FAeZ3K4Ry1OmQXM29Ozb2/6QCMi60BBKnovuJJRAb6UKkpBovQaHHkZoz0CkDbOzfPluE5blqvxACiSDtwOdOcbmsGrXFbo9I8uaKdmbgJSCQ+W5t0qZJpZ40wko7Ot7osmLFkaRZbDsYdFHrIth+SWlpDy61FXTTxgt/p7vSQQZENoyLNltks2NvT5+oOGaoZkatOoRTi7UJ09pO05JASY2c5TT9Vak8AaREcaUHoy9SitYY0bykvTcmX/x/YQpWmCCvKLRMV0+mNa1fNuyh53QnF36YYM5yrLbyoKT6nuousmH3bM7YgASXtdZ/Cjiy98IJR3q6brTtaTQ4DAK+FewgzLwM= angelmac@Angels-MacBook-Air.local"
}

resource "aws_security_group" "ssh_connection" {
	name = var.sg_name
	dynamic "ingress" {
		for_each = var.ingress_rule
		content {
			from_port   = ingress.value.from_port
			to_port     = ingress.value.to_port 
			protocol    = ingress.value.protocol 
			cidr_blocks = ingress.value.cidr_blocks 
		}
	}
}



resource "aws_instance" "ag-instance" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  tags            = var.tags
  security_groups = [aws_security_group.ssh_connection.name]
}