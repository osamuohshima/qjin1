class ActiveRecordBrowser::ApplicationController < ApplicationController
  private

  def render_scaffold(action=nil)
    action ||= caller_method_name(caller)
    template_path = arb_template_path(controller_path, action)
    if arb_template_exists?(template_path)
      render(:file=>template_path, :use_full_path=>true)
    else
      add_instance_variables_to_assigns
      @template.instance_variable_set(
        "@content_for_layout",
        @template.render_file(
          scaffold_path(action.sub(/$/, "")),
          false
        )
      )
      render(:file=>scaffold_path('layout'))
    end
  end

  FormatSuffixes = {
    "html" => ".html",
    "xml" => ".xml",
  }.with_indifferent_access

  def scaffold_path(template_name)
    dir = File.expand_path("../../templates", File.dirname(__FILE__))
    suffix = FormatSuffixes[params[:format]] || ".html"
    return File.join(dir, template_name + "#{suffix}.erb")
  end

  def caller_method_name(caller)
    caller.first.scan(/`(.*)'/).first.first # ' ruby-mode
  end

  def controller_path
    self.class.controller_path
  end

  def arb_template_path(controller, action)
    suffix = FormatSuffixes[params[:format]] || ".html"
    return File.join(controller, "#{action + suffix}.erb")
  end

  def arb_template_exists?(template_path)
    path = view_paths.find do |view_path|
      File.exists?(File.join(view_path, template_path))
    end
    return false unless path
    return true
  end
end
