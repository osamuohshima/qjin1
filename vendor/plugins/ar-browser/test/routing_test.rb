require  File.expand_path('../../../../test/test_helper', File.dirname(__FILE__))

class RoutingTest < ActiveSupport::TestCase
  def test_routing_for_admin
    with_routing do |set|
      set.draw do |map|
        # active_record_browser routing
        map.connect "/admin",
                    :controller=>"active_record_browser/contents",
                    :action=>"services"

        # default routing
        map.connect ':controller/:action/:id'
        map.connect ':controller/:action/:id.:format'

        # active_record_browser routing
        map.connect "/admin/:model/:action/:id",
                    :controller=>"active_record_browser/contents"

        # routing test 
        assert_generates("admin/#{singular_model_name}",
                         :controller=>"admin/#{singular_model_name}")
        assert_generates("admin/#{singular_model_name}/list",
                         :controller=>"admin/#{singular_model_name}",
                         :action=>"list")
        assert_generates("admin/#{singular_model_name}/edit/4",
                         :controller=>"admin/#{singular_model_name}",
                         :action=>"edit",
                         :id=>"4")

        # services
        assert_recognizes({:controller=>"active_record_browser/contents", :action=>"services",},
                          "admin")
        assert_generates("admin",
                         :controller=>"active_record_browser/contents",
                         :action=>"services")

        # model
        assert_routing("admin/#{singular_model_name}",
                       :controller=>"active_record_browser/contents",
                       :action=>"index",
                       :model=>singular_model_name)
        assert_routing("admin/#{singular_model_name}/list",
                       :controller=>"active_record_browser/contents",
                       :action=>"list",
                       :model=>singular_model_name)
        assert_routing("admin/#{singular_model_name}/edit/1",
                       :controller=>"active_record_browser/contents",
                       :action=>"edit",
                       :id=>"1",
                       :model=>singular_model_name)
      end
    end
  end

  private

  def model
    table_names = ActiveRecord::Base.connection.tables
    model_name = table_names.find{|name| Object.const_get(name.classify) rescue nil }
    unless model_name
      raise "Model not found"
    end
    return Object.const_get(model_name.classify)
  end

  def singular_model_name
    model.name.downcase
  end
end
