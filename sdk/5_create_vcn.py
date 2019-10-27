# Creating a VCN with Python SDK
import oci
config = oci.config.from_file()
identity_client = oci.identity.IdentityClient(config)
tenancy_id = config["tenancy"]
compartment = identity_client.list_compartments(tenancy_id)
print(compartment.data)

compartment_id = "ocid1.compartment.oc1..aaaaaaaas2dn6zl2wfmu7nyhu3itqzwfas6p63us535ed734wpqpdtykyuaq"

virtual_network_client = oci.core.virtual_network_client.VirtualNetworkClient(config)

# Prepare OCI request by assigning the desired VCN Parameters
from oci.core.models import CreateVcnDetails
request = CreateVcnDetails()
request.compartment_id = compartment_id
request.display_name = "pythonvcn"
request.dns_label = "pythonvcn"
request.cidr_block = "172.16.0.0/16"

vcn = virtual_network_client.create_vcn(request)