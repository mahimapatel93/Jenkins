module "networking" {
  source         = "../../modules/networking"
  vpc_cidr_block = "10.0.0.0/16"

  vpc_name = "master-vpc"

  frontend_pvt_subnet_1_cidr_block = "10.0.1.0/24"
  frontend_pvt_subnet_2_cidr_block = "10.0.2.0/24"
  lb_public_subnet_1_cidr_block    = "10.0.5.0/24"
  lb_public_subnet_2_cidr_block    = "10.0.6.0/24"

  subnet_1a_az = "us-east-1a"
  subnet_1b_az = "us-east-1b"

  frontend_pvt_1_name = "private-subnet-1"
  frontend_pvt_2_name = "private-subnet-2"
  lb_public_1_name    = "public-subnet-1"
  lb_public_2_name    = "public-subnet-2"

  allowed_ssh_cidr = ["0.0.0.0/0"]
}

# bation server module
module "ec2_instances" {
  source            = "../../modules/ec2"
  key_name          = "himasi"
  security_group_id = module.networking.security_group_id

  instances = {
    bastion = {
      name          = "bastion"
      ami_id        = "ami-068c0051b15cdb816"
      instance_type = "t2.micro"
      subnet_id     = module.networking.lb_public_subnet_ids[0]
      public_ip     = true
    }

    slave1 = {
      name          = "slave-1"
      ami_id        = "ami-068c0051b15cdb816"
      instance_type = "t2.medium"
      subnet_id     = module.networking.lb_public_subnet_ids[0]
      public_ip     = true
    }

    slave2 = {
      name          = "slave-2"
      ami_id        = "ami-068c0051b15cdb816"
      instance_type = "t2.medium"
      subnet_id     = module.networking.lb_public_subnet_ids[0]
      public_ip     = true
    }

    master = {
      name          = "jenkins-master"
      ami_id        = "ami-068c0051b15cdb816"
      instance_type = "t2.medium"
      subnet_id     = module.networking.frontend_private_subnet_ids[0]
      public_ip     = false
    }
  }

#   front_lb_name        = "front-LB"
#   front_tg_name        = "front-TG"
#   vpc_id               = module.networking.vpc_id
#   front_lb_sg_id       = module.networking.security_group_id
#   lb_public_subnet_ids = module.networking.lb_public_subnet_ids
}




# # frontend load balancer & tg module
# module "frontend_lb" {
#   source               = "../../modules/ec2"
#   front_lb_name        = "front-LB"
#   front_tg_name        = "front-TG"
#   vpc_id               = module.networking.vpc_id
#   front_lb_sg_id       = module.networking.security_group_id
#   lb_public_subnet_ids = module.networking.lb_public_subnet_ids

# }

