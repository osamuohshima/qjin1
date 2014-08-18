module ActiveRecordBrowser::ApplicationHelper
  def arb_link_to_top
    link_to("TOP", :controller=>"active_record_browser/contents", :action=>"services")
  end

  def arb_image_tag(src, options={})
    image_tag("active_record_browser/#{src}", options)
  end

  def arb_submit_tag(text, options={})
    default_options = {
      :href=>"javascript:void(document.forms[0].submit());",
      :class=>"submitBtn"
    }
    attrs = default_options.merge(options).collect do |key, value|
      "#{key.to_s}='#{value}'"
    end
    return <<-EOB
<div class="btnL">
  <a #{attrs.join(" ")}>#{h(text)}</a>
</div>
    EOB
  end

  def arb_link_to_sort(column)
    name = column.name
    except_type = [:string, :text, :binary, :longblob, :boolean]
    return name if except_type.include?(column.type)
    params = request.parameters.dup
    params["action"] = "list"
    if params["sort"] == name
      if params["order"] == "desc"
        params["order"] = "asc"
      else
        params["order"] = "desc"
      end
    else
      params.delete("order")
      params["sort"] = name
    end
    return link_to(name, params)
  end
end
