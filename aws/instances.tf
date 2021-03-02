data "aws_ami" "centos7" {
  owners = [
  "679593333241"]
  most_recent = true

  filter {
    name = "name"
    values = [
    "Centos8 Clean Install-*"]
  }

  filter {
    name = "architecture"
    values = [
    "x86_64"]
  }

  filter {
    name = "root-device-type"
    values = [
    "ebs"]
  }
}

resource "aws_instance" "privx" {
  ami           = data.aws_ami.centos7.id
  instance_type = var.instance_type_privx
  tags = {
    Name      = "PrivX-terraform"
    Terraform = "True"
  }
  vpc_security_group_ids = [aws_security_group.privx.id]
  subnet_id              = aws_default_subnet.subnet_1.id
  root_block_device {
    delete_on_termination = true
  }
  associate_public_ip_address = true
  key_name                    = var.key_name
  provisioner "remote-exec" {
    inline = [
      "sudo dnf install epel-release -y -q",
      "sudo dnf install cloud-utils-growpart -y -q",
      "sudo growpart /dev/xvda 2",
      "sudo xfs_growfs -d /",
      "sudo rpm --import https://product-repository.ssh.com/info.fi-ssh.com-pubkey.asc",
      "sudo curl https://product-repository.ssh.com/rhel8/ssh-products.repo -o /etc/yum.repos.d/ssh-products.repo",
      "sudo dnf install -y -q PrivX",
      "cat <<EOF > config.sh",
      "export PRIVX_DNS_NAMES=\"${self.private_dns} ${self.public_dns}\"",
      "export PRIVX_IP_ADDRESSES=\"${self.private_ip} ${self.public_ip}\"",
      "export PRIVX_SUPERUSER=\"${var.privx_superuser}\"",
      "export PRIVX_SUPERUSER_PASSWORD=\"${random_password.superuser_password.result}\"",
      "export PRIVX_SUPERUSER_EMAIL=\"${var.privx_superuser}@example.com\"",
      "export PRIVX_USE_EXTERNAL_DATABASE=0",
      "export PRIVX_DATABASE_NAME=privx",
      "export PRIVX_DATABASE_USERNAME=privx",
      "export PRIVX_DATABASE_PASSWORD=\"${random_password.database_password.result}\"",
      "export PRIVX_DATABASE_SSLMODE=require",
      "export PRIVX_KEYVAULT_PKCS11_ENABLE=0",
      "export PRIVX_NTP_SERVER=pool.ntp.org",
      "/opt/privx/scripts/postinstall.sh",
      "EOF",
      "sudo bash config.sh",
      "rm -rf config.sh"
    ]
    connection {
      host        = self.public_dns
      user        = var.os_username
      private_key = var.ssh_private_key_data == null ? file(var.ssh_private_key_file) : var.ssh_private_key_data
    }
  }
}
