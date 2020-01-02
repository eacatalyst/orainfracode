provider "oci" {
    version =">=3.11"
    tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaak36n5xhazhn2wtrihjone4qwpbj6ll4ow5csavwv5r5zer3xbmsq"
    user_ocid = "ocid1.user.oc1..aaaaaaaagphmqxadjcqdctbzlh2myfh65osi5ve5l6trldrbhz7uqijv6a4a"
    fingerprint = "56:74:88:f0:cf:10:01:32:58:cc:80:70:e1:0c:74:a3"
    private_key_path = "/home/opc/.oci/oci_api_key.pem"
    region = "us-ashburn-1"

}

resource "oci_core_vcn" "simple-vcn" {
    cidr_block = "10.0.0.0/16"
    dns_label = "vcn1"
    compartment_id = "ocid1.compartment.oc1..aaaaaaaa5yoyzxwnutgi4r66doiljyh43hum7yflod54hviezyzwppdvxgjq"
    display_name = "simple-vcn"
}

output "vcnid" {
    value = "${oci_core_vcn.simple-vcn.id}"
}