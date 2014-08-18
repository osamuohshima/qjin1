require File.expand_path("lib/active_record_browser", File.dirname(__FILE__))
require File.expand_path("lib/active_record_browser/csv_handler", File.dirname(__FILE__))

class ActionController::Routing::RouteSet
  def draw_with_active_record_browser
    draw_without_active_record_browser do |map|
      admin_root = ActiveRecordBrowser::ADMIN_ROOT
      map.connect admin_root,
                  :controller=>"active_record_browser/contents",
                  :action=>"services"

      yield(map) # exec config/routes.rb

      map.connect "#{admin_root}/:model/:action/:id",
                  :controller=>"active_record_browser/contents"
    end
  end
  alias_method_chain :draw, :active_record_browser
end

class << ActiveRecord::Base
  include ActiveRecordBrowser::CsvHandler
end
