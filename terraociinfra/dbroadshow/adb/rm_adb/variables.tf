// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

# Not required for resource manager
# variable "user_ocid" {}
# variable "fingerprint" {}
# variable "private_key_path" {}
variable "tenancy_ocid" {}
variable "region" {}
variable "compartment_ocid" {}

variable "autonomous_database_backup_display_name" {
  default = "Monthly Backup"
}

variable "autonomous_database_db_workload" {
  default = "OLTP"
}

variable "autonomous_data_warehouse_db_workload" {
  default = "DW"
}

variable "autonomous_database_defined_tags_value" {
  default = "value"
}

variable "autonomous_database_freeform_tags" {
  default = {
    "Department" = "PM Labs"
  }
}

variable "autonomous_database_license_model" {
  default = "LICENSE_INCLUDED"
}

variable "autonomous_database_is_dedicated" {
  default = false
}