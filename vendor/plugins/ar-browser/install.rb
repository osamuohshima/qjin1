require File.expand_path("../../../config/boot", File.dirname(__FILE__))
require "ftools"

IGNORE_ENTRIES = [".", "..", ".svn"].freeze
ADMIN_DIR_NAME = "active_record_browser"
RESOURCE_DIR_PATH = File.expand_path("resource", File.dirname(__FILE__))
PUBLIC_DIR_PATH   = File.expand_path("public", RAILS_ROOT)

def create_admin_dir(resource_name)
  admin_dir = File.join(PUBLIC_DIR_PATH, "#{resource_name}/#{ADMIN_DIR_NAME}")
  unless File.directory?(admin_dir)
    result = File.makedirs(admin_dir)
  end
  return admin_dir
end

def resource_path(resource_name)
  return File.join(RESOURCE_DIR_PATH, resource_name)
end

def copy(from, to)
  Dir.foreach(from) do |entry|
    next if IGNORE_ENTRIES.include?(entry)
    File.cp(File.join(from, entry), to)
  end
end

def setup(resource_name)
  images_dir = resource_path(resource_name)
  admin_images_dir = create_admin_dir(resource_name)
  copy(images_dir, admin_images_dir)
end

setup("images")
setup("stylesheets")
setup("javascripts")
