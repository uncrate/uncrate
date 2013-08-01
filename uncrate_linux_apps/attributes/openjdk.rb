override['java']['jdk_version'] = '7'

# Workaround to force reload of the java cookbook attributes with the new jdk_version
node.from_file(run_context.resolve_attribute(*parse_attribute_file_spec("java")))