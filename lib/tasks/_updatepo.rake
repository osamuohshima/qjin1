require 'rubygems'
require 'gettext/utils'

namespace :gettext do
  desc 'Update pot/po files.'
  task :updatepo do
    Gettext.update_pofiles('qjin', 
                           Dir.glob("{app, config, lib}/**/*.{rb,rhtml,erb}"),
                           'qjin1.0.0'
                              )
  end

  desc 'Create mo-files'
  task :makemo do
    Gettext.create_mofiles(true, 'po', 'locate')
  end
end
