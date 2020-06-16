terraform {
  backend "http" {
    address       = "https://objectstorage.us-ashburn-1.oraclecloud.com/p/tM87FUDam3bc_mpScojXBxvyP-p6kc2KwmE3nUyE3-Q/n/c4u03/b/bucket-dbroadshow-dev/o/iaac/linux-compute/terraform.tfstate"
    update_method = "PUT"
  }
}