module "dev-1" {
    source = "../terraform"
    ami_id = "var.ami_id"
    instance_type = "var.instance_type"

  
}