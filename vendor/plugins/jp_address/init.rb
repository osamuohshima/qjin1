JPADDRESS_DATABASE_YML = File.expand_path(File.join(RAILS_ROOT, 'vendor/plugins/jp_address/config/database.yml'))
JpAddress.config = YAML.load_file(JPADDRESS_DATABASE_YML)

require 'jp_address'