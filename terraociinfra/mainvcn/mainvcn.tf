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

#---- Create a new VCN

variable "VCN-terraform" {default = "10.0.0.0/16"}
resource "oci_core_virtual_network" "terraform-vcn" {
    cidr_block = "${var.VCN-terraform}"
    compartment_id = "${var.compartment_ocid}"
    display_name = "terraform-vcn"
    dns_label ="terraformvcn"
}

# --- Create a new Internet Gateway
resource "oci_core_internet_gateway" "terraform-ig" {
    compartment_id = "${var.compartment_ocid}"
    display_name = "terraform-internet-gateway"
    vcn_id = "${oci_core_virtual_network.terraform-vcn.id}"
}
 #---- Create Route Table
 resource "oci_core_route_table" "terraform-rt" {
     compartment_id = "${var.compartment_ocid}"
     vcn_id = "${oci_core_virtual_network.terraform-vcn.id}"
     display_name = "terraform-route-table"
     route_rules {
         cidr_block = "0.0.0.0/0" 
         network_entity_id = "${oci_core_internet_gateway.terraform-ig.id}"
     }
 }

 #--- Create a public Subnet 1 in AD1 in the new vcn
 resource "oci_core_subnet" "terraform-public-subnet1" {
     availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1], "name")}"
     cidr_block = "10.0.1.0/24"
     display_name = "terraform-public-subnet1"
     dns_label = "subnet1"
     compartment_id = "${var.compartment_ocid}"
     vcn_id = "${oci_core_virtual_network.terraform-vcn.id}"
     route_table_id = "${oci_core_route_table.terraform-rt.id}"
     dhcp_options_id = "${oci_core_virtual_network.terraform-vcn.default_dhcp_options_id}"
 }

