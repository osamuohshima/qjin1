class ActiveRecordBrowser::LinkRenderer < WillPaginate::LinkRenderer
  protected

  def page_link_or_span(page, span_class = 'current', text = nil)
    text ||= page.to_s
    if page and page != current_page and span_class == 'disabled'
      @template.content_tag :span, @template.link_to(text, url_options(page))
    else
      super
    end
  end

  def url_options_with_active_record_browser(page)
    params.delete(:controller)
    return url_options_without_active_record_browser(page)
  end
  alias_method_chain :url_options, :active_record_browser
end
