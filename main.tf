provider "aws" {
  region      = var.aws_region 
  access_key  = var.access_key
  secret_key  = var.secret_key
  token       = var.token_key
}

# Define the VPC
data "aws_vpc" "default" {
  id = var.vpc_id
}

# Define the Security Group
resource "aws_security_group" "k8s_sg" {
  name_prefix = "k8s-sg-"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 81
    to_port     = 81
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "k8s-sg"
  }
}

# Define EC2 instances
resource "aws_instance" "kubernetes_nodes" {
  count                       = var.total_instances
  ami                         = "ami-0e86e20dae9224db8" 
  instance_type               = count.index == 0 ? "t2.medium" : "t2.micro" # Master node as t2.medium, others as t2.micro
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.k8s_sg.id]
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id

  tags = {
    Name = count.index == 0 ? "master-node" : "worker-node-${count.index}"
#    Role = count.index == 0 ? "master" : "worker"
  }

#  provisioner "file" {
#    source      = var.install_docker_source
#    destination = "/home/ubuntu/install_docker.yml"
#    connection {
#      type        = "ssh"
#      user        = "ubuntu"
#      private_key = file(var.private_key_path)
#      host        = self.public_ip
#    }
#  }

  provisioner "file" {
    source      = var.install_jenkins_source
    destination = "/home/ubuntu/install_jenkins.yml"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

#  provisioner "file" {
#    source      = var.install_kubernetes_source
#    destination = "/home/ubuntu/install_kubernetes.yml"
#    connection {
#      type        = "ssh"
#      user        = "ubuntu"
#      private_key = file(var.private_key_path)
#      host        = self.public_ip
#    }
#  }

  provisioner "file" {
    source      = var.install_dock_kube_tools_source
    destination = "/home/ubuntu/install_dock_kube_tools.yml"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  provisioner "file" {
    source      = var.setup_kubernetes_master_source
    destination = "/home/ubuntu/setup_kubernetes_master.yml"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  provisioner "file" {
    source      = var.setup_kubernetes_worker_source
    destination = "/home/ubuntu/setup_kubernetes_worker.yml"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install ansible -y ",
      "ansible-playbook /home/ubuntu/install_docker.yml",
#      "ansible-playbook /home/ubuntu/install_jenkins.yml",
#      "ansible-playbook /home/ubuntu/install_kubernetes.yml",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  depends_on = [
    aws_security_group.k8s_sg
  ]
}

# Provision the master node
#resource "null_resource" "run_setup_kubernetes_master_playbook" {
#  count = var.total_instances > 0 ? 1 : 0
#
#  provisioner "remote-exec" {
#    inline = [
#      "ansible-playbook /home/ubuntu/setup_kubernetes_master.yml"
#    ]
#
#    connection {
#      type        = "ssh"
#      user        = "ubuntu"
#      private_key = file(var.private_key_path)
#      host        = aws_instance.kubernetes_nodes[0].public_ip
#    }
#  }
#
#  depends_on = [
#    aws_instance.kubernetes_nodes
#  ]
#}
#
# Provision worker nodes
#resource "null_resource" "run_worker_playbooks" {
#  count = var.total_instances > 1 ? var.total_instances - 1 : 0
#
#  provisioner "remote-exec" {
#    inline = [
#      "ansible-playbook /home/ubuntu/setup_kubernetes_worker.yml"
#    ]
#
#    connection {
#      type        = "ssh"
#      user        = "ubuntu"
#      private_key = file(var.private_key_path)
#      host        = aws_instance.kubernetes_nodes[count.index + 1].public_ip
#    }
#  }
#
#  depends_on = [
#    null_resource.run_setup_kubernetes_master_playbook
#  ]
#}

# Output the public IPs of the instances
output "instance_ips" {
  value = aws_instance.kubernetes_nodes[*].public_ip
}

