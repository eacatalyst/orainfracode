// 05/04/2020  Database Lap ADW 

resource "random_string" "autonomous_data_warehouse_admin_password" {
  length      = 16
  min_numeric = 1
  min_lower   = 1
  min_upper   = 1
  min_special = 1
}

data "oci_database_autonomous_db_versions" "test_autonomous_dw_versions" {
  #Required
  compartment_id = "${var.compartment_ocid}"

  #Optional
  db_workload = "${var.autonomous_data_warehouse_db_workload}"
}

resource "oci_database_autonomous_database" "autonomous_data_warehouse" {
  #Required
  #count                    = "${var.instance_count}"
  admin_password           = "${random_string.autonomous_data_warehouse_admin_password.result}"
  compartment_id           = "${var.compartment_ocid}"
  cpu_core_count           = "1"
  data_storage_size_in_tbs = "1"
  db_name                  = "odi12cb00"
  #db_name                  = "adwclone-${count.index}"

  #Optional
  # db_version              = "${data.oci_database_autonomous_db_versions.test_autonomous_dw_versions.autonomous_db_versions.0.version}"
  db_workload             = "${var.autonomous_data_warehouse_db_workload}"
  display_name            = "ODI_12c_Training_ADW_Baseline"
  freeform_tags           = "${var.autonomous_database_freeform_tags}"
  is_auto_scaling_enabled = "false"
  license_model           = "${var.autonomous_database_license_model}"

  # Optional for ODI12cLab
  clone_type = "FULL"
  source     = "DATABASE"
  source_id  = "ocid1.autonomousdatabase.oc1.iad.abuwcljrnr4hg5xie6qzeebzdlqfzgsuu5yhwadizcloypmanto7fnsjvqxa"
}

data "oci_database_autonomous_databases" "autonomous_data_warehouses" {

  # count         = "${var.instance_count}"
  #Required
  compartment_id = "${var.compartment_ocid}"

  #Optional
  display_name = "${oci_database_autonomous_database.autonomous_data_warehouse.display_name}"
  db_workload  = "${var.autonomous_data_warehouse_db_workload}"
}

output "autonomous_data_warehouse_admin_password" {
  value = "${random_string.autonomous_data_warehouse_admin_password.result}"
}

# /*  -- removing output during troubleshooting 06/12/2020
output "autonomous_data_warehouse_high_connection_string" {
  value = "${lookup(oci_database_autonomous_database.autonomous_data_warehouse.connection_strings.0.all_connection_strings, "high", "unavailable")}"
}

output "autonomous_data_warehouses" {
  value = "${data.oci_database_autonomous_databases.autonomous_data_warehouses.autonomous_databases}"
}

# */

