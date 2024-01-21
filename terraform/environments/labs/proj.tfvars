environment = "labs"
proj_name   = "z"

aws_region  = "eu-north-1"
aws_profile = "default"

vpc_network               = "10.31.0.0/16"
vpc_private_networks_list = ["10.31.1.0/24", "10.31.2.0/24"]
vpc_public_networks_list  = ["10.31.201.0/24", "10.31.202.0/24"]

ec2_private_key_filename = "ec2-private-key.pem"
ec2_key_pair_name        = "ec2-key-pair"

kube_version     = "1.28"
kube_nodes_types = ["t3.medium"]
kube_nodes_count = 2
