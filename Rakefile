# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

#for gettext
desc "Update pot/po files."
task :updatepo do
  require 'gettext/utils'
  GetText.update_pofiles("qjin",
                         Dir.glob("{app,config,components,lib}/**/*.{rb,rhtml}"),
                         "qjin 1.0.0"
                         )
end

desc "Create mo-files"
task :makemo do
  require 'gettext/utils'
  GetText.create_mofiles(true, "po", "locale")
end


