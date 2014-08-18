require 'pathname'
ATTACH_ROOT = "#{RAILS_ROOT}/public/attached"

class Attachment < ActiveRecord::Base

   def self.save(attached)
     dirname = "#{RAILS_ROOT}/public/attached/#{attached[:uketsuke_nen].to_s}"
     Dir.mkdir(dirname) unless File.exist? dirname
     File.open("#{dirname}/#{attached["file"].original_filename}", "wb") do |f|
       f.write(attached["file"].read)
     end
   end
  def self.info(content_id, filename)
    dirname = attach_dir  content_id
    Pathname.new(File.join dirname, filename)
  end

   private
   def self.attach_dir(content_id)
     "#{ATTACH_ROOT}/#{content_id.to_s}"
   end
 end
