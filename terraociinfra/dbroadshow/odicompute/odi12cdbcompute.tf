variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
# variable "public_subnet_id" {}
variable "public_subnet_id" {default = "ocid1.subnet.oc1.iad.aaaaaaaadxljdg26ieohiq6mw7ccmhv2ca4mqkub5bzmd6r7axszbhlwm6aq"}
variable "AD" { default = 1 }

variable "Image-Id" { default = "ocid1.image.oc1.iad.aaaaaaaatnyrp5t27lr4pwhhjfiyyrdwvrjdsin5tfrzpiutcdarqn3vnqfa" }

variable "instance_shape" {
  default = "VM.Standard2.1"
}

variable "compartment_ocid" {}
variable "ssh_public_key" {default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDqlBzbu2x3XlFVNCqlZbKdsG36PrGIEbzAla2ilDEZwBMzMNVYRH2N7BpmnqrX9yOPiP7gvSezYYbe0FVI+nM+UxCD/ienWV4d7x/p7aDF9taePrBd6DQ230l+ljBm9h2lhJez4Jyi6ouwawb4gaR8F+/fAVAdFGuEyHIhwr2HtA65B/bMiml1MxE1VdVKTC9fdfswctAsJqNcbYUWWVzr1XGub8iwc4RAY3itpDQ3Fp3cv/YHOaTx9deJG6CduAmKfxRskBVRitAJFerQJWoswz3Yz/UkQe1bUzktJ4FyHcNagvhskgjABh0cbZSZT2V1MfPusWdyu563hEHSNIvH Clayson@DESKTOP-NEULI8N"}

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
  default = "1"
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
  display_name        = "odi12clab-${count.index}"
  shape               = "${var.instance_shape}"

  create_vnic_details {
    subnet_id        = "${var.public_subnet_id}"
    display_name     = "Primaryvnic"
    assign_public_ip = true
    hostname_label   = "odi12c1-${count.index}"
  }

  source_details {
    source_type = "image"
    source_id   = "${var.Image-Id}"

  }
}