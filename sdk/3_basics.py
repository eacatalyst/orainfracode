import oci
config = oci.config.from_file()
print(config)

identity=oci.identity.IdentityClient(config)
compartment_id=config["tenancy"]
print(identity.base_client.endpoint)

regions=identity.list_regions()
print(regions.data)

print(compartment_id)

userlist = identity.list_users(compartment_id)
print(userlist.data)
