resource "aws_key_pair" "key_acesso" { #ssh-keygen -f aws-key
  key_name   = "aws-key"
  public_key = var.aws_key_pub

}


resource "aws_instance" "vm" {
  ami                         = "ami-0b8b44ec9a8f90422"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.key_acesso.key_name
  subnet_id                   = data.terraform_remote_state.vpc.outputs.subnet_id
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.security_id]
  associate_public_ip_address = true

  tags = {
    Name = "vm-terraform"
  }
}

#Entrar na maquina ssh -i aws-key ubuntu@3.142.241.204