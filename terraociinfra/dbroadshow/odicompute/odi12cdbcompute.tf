variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "public_subnet_id" {}
variable "AD" { default = 1 }

variable "Image-Id" { default = "ocid1.image.oc1.iad.aaaaaaaasp5ttepfvz562mayqrmnkxskunnda4wjcbjzworhysdxwewi7z3a" }

variable "instance_shape" {
  default = "VM.Standard2.1"
}

variable "compartment_ocid" {}
variable "ssh_public_key" {}
variable "ssh_private_key" {}

data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}

provider "oci" {
  tenancy_ocid     = "${var.tenancy_ocid}"
  user_ocid        = "${var.user_ocid}"
  fingerprint      = "${var.fingerprint}"
  private_key_path = "${var.private_key_path}"
  region           = "${var.region}"
}

# Defines the number of instances to deploy
variable "num_instances" {
  default = "3"
}

/* Hardcoding image 
variable "instance_image_ocid" {
  type = "map"

  default = {
    # See https://docs.us-phoenix-1.oraclecloud.com/images/
    # Oracle-provided image "Oracle-Linux-7.5-2018.10.16-0"
    us-ashburn-1   = "ocid1.image.oc1..aaaaaaaat3a7crj3xn2dbqshdbxo4eiwtlqaqu5ozdzmf2os352n4cj2s2xa"
    eu-frankfurt-1 = "ocid1.image.oc1..aaaaaaaat3a7crj3xn2dbqshdbxo4eiwtlqaqu5ozdzmf2os352n4cj2s2xa"
    uk-london-1    = "ocid1.image.oc1..aaaaaaaat3a7crj3xn2dbqshdbxo4eiwtlqaqu5ozdzmf2os352n4cj2s2xa"
  }
}
*/

resource "oci_core_instance" "odi_12c_train" {
  count = "${var.num_instances}"
  #availability_domain = "${data.oci_identity_availability_domain.ad.name}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1], "name")}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "odi12c-${count.index}"
  shape               = "${var.instance_shape}"

  create_vnic_details {
    subnet_id        = "${var.public_subnet_id}"
    display_name     = "Primaryvnic"
    assign_public_ip = true
    hostname_label   = "odi12c-${count.index}"
  }

  source_details {
    source_type = "image"
    source_id   = "${var.Image-Id}"

  }
}