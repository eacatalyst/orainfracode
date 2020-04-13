
# variable "user_ocid" {}
# variable "fingerprint" {}
# variable "private_key_path" {}
variable "region" {}

variable "tenancy_ocid" {}


variable "ssh_private_key" {}
variable "ssh_public_key" {}

variable "compartment_ocid" {}

provider "oci" {
  version          = ">= 3.0.0"
  tenancy_ocid     = "${var.tenancy_ocid}"
  region           = "us-ashburn-1"
  # ---Variables Not Required When Using OCI-Resource Manager ------#
  #user_ocid        = "${var.user_ocid}"
  #fingerprint      = "${var.fingerprint}"
  #private_key_path = "${var.private_key_path}"
  
}

data "oci_identity_availability_domains" "ashburn" {
  compartment_id = "${var.tenancy_ocid}"
}

### Network Variables ##### 

variable "vcn_cidr_block" {
  default = "10.0.0.0/16"
}

variable "dns_label_vcn" {
  default = "dnsvcn"
}

variable "subnet_cidr_w1" {
  default = "10.0.1.0/24"
}

variable "subnet_cidr_w2" {
  default = "10.0.2.0/24"
}

variable "subnet_cidr_lb1" {
  default = "10.0.10.0/24"
}

variable "subnet_cidr_lb2" {
  default = "10.0.20.0/24"
}

variable "instance_shape" {
  default = "VM.Standard1.2"
}

variable "cluster_kubernetes_version" {
  default = "v1.15.7"
}

variable "cluster_name" {
  default = "OKE_Micro_Services"
}

variable "availability_domain" {
  default = 3
}

variable "cluster_options_add_ons_is_kubernetes_dashboard_enabled" {
  default = true
}

variable "cluster_options_add_ons_is_tiller_enabled" {
  default = true
}

variable "cluster_options_kubernetes_network_config_pods_cidr" {
  default = "10.1.0.0/16"
}

variable "cluster_options_kubernetes_network_config_services_cidr" {
  default = "10.2.0.0/16"
}

variable "node_pool_initial_node_labels_key" {
  default = "project"
}

variable "node_pool_initial_node_labels_value" {
  default = "dev"
}

variable "node_pool_kubernetes_version" {
  default = "v1.15.7"
}

variable "node_pool_name" {
  default = "NodePool_1"
}

variable "node_pool_node_image_name" {
  default = "Oracle-Linux-7.6"
}

variable "node_pool_node_shape" {
  default = "VM.Standard1.2"
}

variable "node_pool_quantity_per_subnet" {
  default = 1
}

variable "node_pool_ssh_public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDqlBzbu2x3XlFVNCqlZbKdsG36PrGIEbzAla2ilDEZwBMzMNVYRH2N7BpmnqrX9yOPiP7gvSezYYbe0FVI+nM+UxCD/ienWV4d7x/p7aDF9taePrBd6DQ230l+ljBm9h2lhJez4Jyi6ouwawb4gaR8F+/fAVAdFGuEyHIhwr2HtA65B/bMiml1MxE1VdVKTC9fdfswctAsJqNcbYUWWVzr1XGub8iwc4RAY3itpDQ3Fp3cv/YHOaTx9deJG6CduAmKfxRskBVRitAJFerQJWoswz3Yz/UkQe1bUzktJ4FyHcNagvhskgjABh0cbZSZT2V1MfPusWdyu563hEHSNIvH Clayson@DESKTOP-NEULI8N"
}
