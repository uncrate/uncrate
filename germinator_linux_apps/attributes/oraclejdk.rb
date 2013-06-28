override['java']['jdk_version'] = '7'
override['java']['install_flavor'] = "oracle"
override['java']['oracle']['accept_oracle_download_terms'] = true

# Workaround to force reload of the java cookbook attributes with the new jdk_version
node.from_file(run_context.resolve_attribute(*parse_attribute_file_spec("java")))