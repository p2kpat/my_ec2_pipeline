access_key       = " paste access key here "
secret_key       = " paste access key here "
token_key        = " paste token key here "
vpc_id           = " update this with the VPC ID or create your own VPC "
subnet_id        = " update this with the VPC ID or create your own subnet(s)"
key_name         = " name of the key pair file saved in your github repo or local directory"
ssh_user         = "ubuntu" 
total_instances  = 2
aws_region       = "us-east-1"
ami_id           = "ami-0e86e20dae9224db8"
private_key_path               = "/home/priyankkpgmail/aws_k8s_pipeline/DevPipeline.pem"
#install_docker_source         = "/home/priyankkpgmail/aws_k8s_pipeline/install_docker.yml"
install_jenkins_source         = "/home/priyankkpgmail/aws_k8s_pipeline/install_jenkins.yml"
#install_kubernetes_source     = "/home/priyankkpgmail/aws_k8s_pipeline/install_kubernetes.yml"
install_dock_kube_tools_source = "/home/priyankkpgmail/aws_k8s_pipeline/install_dock_kube_tools.yml"
setup_kubernetes_master_source = "/home/priyankkpgmail/aws_k8s_pipeline/setup_kubernetes_master.yml"
setup_kubernetes_worker_source = "/home/priyankkpgmail/aws_k8s_pipeline/setup_kubernetes_worker.yml"
