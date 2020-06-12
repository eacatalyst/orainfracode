terraform {
  backend "http" {
    address       = "https://objectstorage.us-ashburn-1.oraclecloud.com/p/qebDEC7v2TQS23t3gMGe5s0xHBaQha_723QrA-1o0IE/n/c4u03/b/bucket-dbroadshow-dev/o/adb/terraform.tfstate"
    update_method = "PUT"
  }
}