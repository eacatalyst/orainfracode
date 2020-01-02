# ---- use variables defined in terraform.tfvars or bash profile file
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}
variable "AD" {}

#---provider

provider "oci" {
    region = "${var.region}"
    tenancy_ocid = "${var.tenancy_ocid}"
    user_ocid = "${var.user_ocid}"
    fingerprint = "${var.fingerprint}"
    private_key_path = "${var.private_key_path}"
}

data "oci_identity_availability_domains" "ADs" {
    compartment_id = "${var.tenancy_ocid}"
}

#---- Create a new Bucket

resource "oci_objectstorage_bucket" "terraform-bucket" {
    compartment_id = "${var.compartment_ocid}"
    namespace = "orasenatdpltdevopsnetw01"
    name = "tf-example-bucket"
    access_type = "NoPublicAccess"
  
}
