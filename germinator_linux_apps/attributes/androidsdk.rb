default['android_sdk']['download_url']="http://dl.google.com/android/android-sdk_r22.0.4-linux.tgz"
default['android_sdk']['checksum']="3eec3c2accfb90d8344d29ed7e80fdf59ea0eecfed3535a7c78116ace5b522e7"
default['android_sdk']['install_dir']="/opt"

default['android_sdk']['include_tools'] = true
default['android_sdk']['include_platform_tools'] = true
default['android_sdk']['include_build_tools'] = false

# Install platform, and google_api add on for each version at a minimum
default['android_sdk']['versions'] = ['18']
default['android_sdk']['include_platform'] = true
default['android_sdk']['include_add_ons'] = true
default['android_sdk']['include_doc'] = false
default['android_sdk']['include_source'] = false
default['android_sdk']['include_system_image'] = false
default['android_sdk']['include_sample'] = false

# additional add ons
default['android_sdk']['add_ons'] = []

#extras
default['android_sdk']['extras'] = []


