terraform {
  backend "http" {
    address       = "https://objectstorage.us-ashburn-1.oraclecloud.com/p/IcK_uuHGem7PziN_sBvUIpi4OQJEXWbUMPUGUyA5wOQ/n/c4u03/b/bucket-dbroadshow-dev/o/terraform.tfstate"
    update_method = "PUT"
  }
}