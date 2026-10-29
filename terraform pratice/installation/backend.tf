terraform{
    backend "s3" {
        bucket = "terraform-state-7408"
        key = "project/terraform.tfstate"
        region = "us-east-1"
    }
}