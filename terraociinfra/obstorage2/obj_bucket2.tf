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

resource "oci_objectstorage_bucket" "bucket1" {
    compartment_id = "${var.compartment_ocid}"
    namespace = "orasenatdpltdevopsnetw01"
    name = "preauth-example-bucket"
    access_type = "NoPublicAccess"
}

resource "oci_objectstorage_preauthrequest" "test_preauthenticated_request" {
    # Required
    access_type = "AnyObjectWrite"
    bucket = "preauth-example-bucket"
    name = "terraform-preauth"
    namespace = "orasenatdpltdevopsnetw01"
    time_expires = "2020-09-01T00:09:51.000+02:00"

  
}

