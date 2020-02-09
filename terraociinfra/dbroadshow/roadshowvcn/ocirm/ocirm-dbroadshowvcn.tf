# ---- use variables defined in terraform.tfvars or bash profile file
# ---Variables Not Required using OCI-Resource Manager ---#

# variable "user_ocid" {}
# variable "fingerprint" {}
# variable "private_key_path" {}
variable "compartment_ocid" {}
variable "tenancy_ocid" {}
variable "region" {}
variable "AD" {default = 1}

terraform {
  required_version = ">= 0.12.0"
}

#---provider

provider "oci" {
    region = "${var.region}"
    tenancy_ocid = "${var.tenancy_ocid}"

# ---Variables Not Required using OCI-Resource Manager ---#

  #  user_ocid = "${var.user_ocid}"
  #  fingerprint = "${var.fingerprint}"
  #  private_key_path = "${var.private_key_path}"
}

data "oci_identity_availability_domains" "ADs" {
    compartment_id = "${var.tenancy_ocid}"
}

#---- Create a new VCN

variable "VCN-dbroadshow" {default = "10.0.0.0/16"}
resource "oci_core_virtual_network" "dbroadshow-vcn" {
    cidr_block = "${var.VCN-dbroadshow}"
    compartment_id = "${var.compartment_ocid}"
    display_name = "dbroadshow-vcn"
    dns_label ="dbroadshowvcn"
}

# --- Create a new Internet Gateway
resource "oci_core_internet_gateway" "dbroadshow-ig" {
    compartment_id = "${var.compartment_ocid}"
    display_name = "dbroadshow-internet-gateway"
    vcn_id = "${oci_core_virtual_network.dbroadshow-vcn.id}"
}
 #---- Create Route Table
 resource "oci_core_route_table" "dbroadshow-rt" {
     compartment_id = "${var.compartment_ocid}"
     vcn_id = "${oci_core_virtual_network.dbroadshow-vcn.id}"
     display_name = "dbroadshow-route-table"
     route_rules {
         cidr_block = "0.0.0.0/0" 
         network_entity_id = "${oci_core_internet_gateway.dbroadshow-ig.id}"
     }
 }

 #--- Create a public Subnet 1 in AD1 in the new vcn
 resource "oci_core_subnet" "dbroadshow-public-subnet1" {
     availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1], "name")}"
     cidr_block = "10.0.1.0/24"
     display_name = "dbroadshow-public-subnet1"
     dns_label = "subnet1"
     compartment_id = "${var.compartment_ocid}"
     vcn_id = "${oci_core_virtual_network.dbroadshow-vcn.id}"
     route_table_id = "${oci_core_route_table.dbroadshow-rt.id}"
     dhcp_options_id = "${oci_core_virtual_network.dbroadshow-vcn.default_dhcp_options_id}"
 }

#--- Create Network Security List

resource "oci_core_security_list" "db-Security-List" {
    display_name = "db-Security-List"
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_virtual_network.dbroadshow-vcn.id}"

    egress_security_rules {
        protocol = "all"
        destination = "0.0.0.0/0"
    }
      
    ingress_security_rules  {
            protocol = "6"
            source = "0.0.0.0/0"

            tcp_options {
                min = 8085
                max = 8085
            }
        }
    ingress_security_rules {
            protocol = "6"
            source = "0.0.0.0/0"

            tcp_options {
                min = 9080
                max = 9080
            }
        }
    ingress_security_rules {
            protocol = "6"
            source = "0.0.0.0/0"

            tcp_options {
                min = 8002
                max = 8002
            }
        }
    ingress_security_rules {
            protocol = "6"
            source = "0.0.0.0/0"

            tcp_options {
                min = 18002
                max = 18002
            }
        }
    ingress_security_rules {
            protocol = "6"
            source = "0.0.0.0/0"

            tcp_options {
                min = 5600
                max = 5600
            }
        }
    ingress_security_rules {
            protocol = "6"
            source = "0.0.0.0/0"

            tcp_options {
                min = 443
                max = 443
            }
        }
    ingress_security_rules {
            protocol = "6"
            source = "0.0.0.0/0"

            tcp_options {
                min = 7803
                max = 7803
            }
        }
    ingress_security_rules {
            protocol = "6"
            source = "0.0.0.0/0"

            tcp_options {
                min = 4903
                max = 4903
            }
        }
    ingress_security_rules {
            protocol = "6"
            source = "0.0.0.0/0"

            tcp_options {
                min = 7301
                max = 7301
            }
        }
    ingress_security_rules {
            protocol = "6"
            source = "0.0.0.0/0"

            tcp_options {
                min = 9851
                max = 9851
            }
        
        }
}

#--- Defualt  Network Security List

resource "oci_core_default_security_list" "default-security-list" {
    manage_default_resource_id = "${oci_core_virtual_network.dbroadshow-vcn.default_security_list_id}" 

    egress_security_rules  {
        protocol = "all"
        destination = "0.0.0.0/0"
    }

        
    ingress_security_rules  {
            protocol = "6"
            source = "0.0.0.0/0"

            tcp_options {
                min = 8085
                max = 8085
            }
        }
    ingress_security_rules {
            protocol = "6"
            source = "0.0.0.0/0"

            tcp_options {
                min = 9080
                max = 9080
            }
        }
    ingress_security_rules {
            protocol = "6"
            source = "0.0.0.0/0"

            tcp_options {
                min = 8002
                max = 8002
            }
        }
    ingress_security_rules {
            protocol = "6"
            source = "0.0.0.0/0"

            tcp_options {
                min = 18002
                max = 18002
            }
        }
    ingress_security_rules {
            protocol = "6"
            source = "0.0.0.0/0"

            tcp_options {
                min = 5600
                max = 5600
            }
        }
    ingress_security_rules {
            protocol = "6"
            source = "0.0.0.0/0"

            tcp_options {
                min = 443
                max = 443
            }
        }
    ingress_security_rules {
            protocol = "6"
            source = "0.0.0.0/0"

            tcp_options {
                min = 7803
                max = 7803
            }
        }
    ingress_security_rules {
            protocol = "6"
            source = "0.0.0.0/0"

            tcp_options {
                min = 4903
                max = 4903
            }
        }
    ingress_security_rules {
            protocol = "6"
            source = "0.0.0.0/0"

            tcp_options {
                min = 7301
                max = 7301
            }
        }
    ingress_security_rules {
            protocol = "6"
            source = "0.0.0.0/0"

            tcp_options {
                min = 9851
                max = 9851
            }
        
        }
}