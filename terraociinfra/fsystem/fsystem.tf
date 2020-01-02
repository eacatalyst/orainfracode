
variable "compartment_ocid" {}
resource "oci_file_storage_mount_target" "test_mount_target" {
  # Required
  availability_domain = "MUMt:US-ASHBURN-AD-3"
  compartment_id = "${var.compartment_ocid}"
  subnet_id = "ocid1.subnet.oc1.iad.aaaaaaaacv2pgpjo4ljwarjpn2q77dxly5iurjnx62yxpeufntlyku35h6iq"

  # optional
  display_name = "terraform_mount"
}

resource "oci_file_storage_export_set" "test_export_set" {
    # Required
    mount_target_id = "${oci_file_storage_mount_target.test_mount_target.id}"

    # Optional
    display_name = "terraform_export"
    max_fs_stat_bytes = 23843202333
    max_fs_stat_files = 223442
}

resource "oci_file_storage_file_system" "test_file_system" {
    # Required
    availability_domain = "MUMt:US-ASHBURN-AD-3"
    compartment_id = "${var.compartment_ocid}"

    # Optional
    display_name = "terraform_filesystem"
}

resource "oci_file_storage_export" "test_export" {
  # Required
  export_set_id = "${oci_file_storage_mount_target.test_mount_target.export_set_id}"
  file_system_id = "${oci_file_storage_file_system.test_file_system.id}"
  
  path = "/terraform_filesystem"
  
  export_options {
      
          source = "0.0.0.0/0"
          access = "READ_WRITE"
          identity_squash = "NONE"
          require_privileged_source_port = false
      }
  export_options {

          source = "0.0.0.0/0"
          access = "READ_ONLY"
          identity_squash = "NONE"
          require_privileged_source_port = false

      }
}






