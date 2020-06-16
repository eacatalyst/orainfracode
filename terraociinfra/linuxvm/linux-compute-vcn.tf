variable "tenancy_ocid" {}
variable "region" {}
variable "display_name" { default = "workshop" }
variable "AD" { default = 1 }
variable "instance_image_ocid" {}
variable "instance_shape" {
  default = "VM.Standard2.1"
}
variable "compartment_ocid" {}
variable "ssh_public_key" {}

terraform {
  required_version = ">= 0.12.0"
}

data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}

provider "oci" {
  tenancy_ocid = "${var.tenancy_ocid}"
  region       = "${var.region}"
}


variable "VCN-example" { default = "10.0.0.0/16" }
resource "oci_core_virtual_network" "example-vcn" {
  cidr_block     = "${var.VCN-example}"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "example-vcn"
  dns_label      = "examplevcn"
}

# --- Create a new Internet Gateway
resource "oci_core_internet_gateway" "example-ig" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "example-internet-gateway"
  vcn_id         = "${oci_core_virtual_network.example-vcn.id}"
}
#---- Create Route Table
resource "oci_core_route_table" "example-rt" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.example-vcn.id}"
  display_name   = "example-route-table"
  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.example-ig.id}"
  }
}

#--- Create a public Subnet 1 in AD1 in the new vcn
resource "oci_core_subnet" "example-public-subnet1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1], "name")}"
  cidr_block          = "10.0.1.0/24"
  display_name        = "example-public-subnet1"
  dns_label           = "subnet1"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.example-vcn.id}"
  route_table_id      = "${oci_core_route_table.example-rt.id}"
  dhcp_options_id     = "${oci_core_virtual_network.example-vcn.default_dhcp_options_id}"
}

#--- Create Network Security List

resource "oci_core_security_list" "db-Security-List" {
  display_name   = "db-Security-List"
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.example-vcn.id}"

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 8085
      max = 8085
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 9080
      max = 9080
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 8002
      max = 8002
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 18002
      max = 18002
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 5600
      max = 5600
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 443
      max = 443
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 7803
      max = 7803
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 4903
      max = 4903
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 7301
      max = 7301
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 9851
      max = 9851
    }

  }
}

#--- Defualt  Network Security List

resource "oci_core_default_security_list" "default-security-list" {
  manage_default_resource_id = "${oci_core_virtual_network.example-vcn.default_security_list_id}"

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }


  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 8085
      max = 8085
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 9080
      max = 9080
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 8002
      max = 8002
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 18002
      max = 18002
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 5600
      max = 5600
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 443
      max = 443
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 7803
      max = 7803
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 4903
      max = 4903
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 7301
      max = 7301
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 9851
      max = 9851
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 22
      max = 22
    }

  }
}


resource "oci_core_instance" "ssworkshop_instance" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1], "name")}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "${var.display_name}"
  shape               = "${var.instance_shape}"

  create_vnic_details {
    subnet_id = "${oci_core_subnet.example-public-subnet1.id}"
    #subnet_id        = "${var.public_subnet_id}"
    display_name     = "Primaryvnic"
    assign_public_ip = true
    # hostname_label   = "ssworkshop-${var.display_name}"
  }

  source_details {
    source_type = "image"
    source_id   = "${var.instance_image_ocid}"

  }

  metadata = {
    ssh_authorized_keys = "${var.ssh_public_key}"
  }

}


