env = ENV['RAILS_ENV']||'development'
database = "qjin_#{env}"
user = "shinro"

task :db_connect => [:environment] do
  ActiveRecord::Base.establish_connection(
                        :adapter => 'mysql',
                        :host => 'localhost', 
                        :userbname => 'root',
                        :password => '',
                        :database => 'mysql'
                )
end

task :db_setup => [:db_connect] do
 ActiveRecord::Schema.define do
   create_database database
   execute "create user #{user}@localhost identified by ''"
   execute "grant all privileges on  #{database}.* to '#{user}'@'localhost'"
 end
end

task :db_clean => [ :db_connect ] do
  ActiveRecord::Schema.define do
   execute "drop user'#{user}'@'localhost'"
   drop_database database
  end

end
