module "memcache"{
    source = "./modules/ec2"
  #  instance_name = "memcache_instance"
}

module "memcache_sg"{
    source = "./modules/security"
   # sg_name  = "memcache"
}

module "rmq"{
    source = "./modules/ec2"
  #  instance_name  = "rmq_instance"
}

module "rmq_sg"{
    source = "./modules/security"
   # sg_name  = "rmq"
}

module "tomcat"{
    source = "./modules/ec2"
   # instance_name  = "tomcat_instance"
}

module "tomcat_sg"{
    source = "./modules/security"
  #  sg_name  = "tomcat"
}

module "nginx"{
    source = "./modules/ec2"
 #   instance_name  = "nginx_instance"
}

module "nginx_sg"{
    source = "./modules/security"
   # sg_name  = "nginx"
}

module "mysql"{
    source = "./modules/ec2"
   # instance_name  = "mysql_instance"
}

module "mysql_sg"{
    source = "./modules/security"
    #sg_name  = "mysql"
    #Name = "mysql"
}