module ActiveRecordBrowser::ContentsHelper
  def arb_all_input_tags_with_columns(record, record_name)
    input_tags = record.class.columns.collect do |column|
      arb_input_block(record_name, column)
    end
    html =<<-EOB
<table cellpadding="0" cellspacing="0" border="0" class="normalList">
#{input_tags.join("\n")}
</table>
    EOB
    return html
  end

  def arb_input_block(record, column)
    return "" if column.primary
    input_tag = case column.type
                when :binary, :longblob
                  "バイナリデータのため作成、編集できません。"
                else
                  input(record, column.name)
                end
    html =<<-EOB
<tr>
<td class="ID">#{column.name}</td>
<td>#{input_tag}</td>
</tr>
    EOB
    return html
  end

  def arb_paginate(records, page_params={})
    per_page = records.per_page
    will_paginate(records, {
      :next_label=>"[次の#{per_page}件]", :prev_label=>"[前の#{per_page}件]",
      :renderer=>"ActiveRecordBrowser::LinkRenderer", :params=>page_params, 
      :separator => '　', :container => false
    })
  end

  def arb_display_column(column, value, options={})
    return "" if value.blank?

    case column.type
    when :integer, :float
      value
    when :decimal
      value
    when :string, :text
      return value unless options[:truncate]
      max_len = 20
      if value.is_utf8?
        value = value.chars
        result = value.size > max_len ? "#{value[0..max_len]} ..." : value
      else
        split_value = value.split(//)
        result = split_value.size > max_len ? "#{split_value[0..max_len].join} ..." : value
      end
      result
    when :datetime, :timestamp
      value.strftime("%Y/%m/%d %H:%M:%S")
    when :time
      value.strftime("%H:%M:%S")
    when :date
      value.strftime("%Y/%m/%d")
    when :binary, :longblob
      "BINARY DATA"
    when :boolean
      value.inspect
    else
      value
    end
  end

  def arb_link_to_record(model, id)
    model_config = ActiveRecordBrowser::ModelConfig.find(model)
    link_to(h("[#{model_config.human_name}]"), {
      :controller => "active_record_browser/contents",
      :model => model.table_name,
      :action => "show",
      :id => id,
    })
  end

  def arb_link_to_search_list(label, model, search_params=[])
    table_name = model.descends_from_active_record? ? \
      model.table_name : model.name.tableize
    options = {
      :action => "list",
      :model => table_name,
    }.with_indifferent_access
    search_params.each_with_index do |(name, value), i|
      options["search_column_#{i}"] = name
      options["search_query_#{i}"] = value
    end
    return link_to(label, options)
  end

  def arb_const_get(const_name)
    names = const_name.split("::")
    return names.inject(Object){|klass, name|
      name.empty? ? klass : klass.const_get(name.classify)
    }
  end

  def arb_link_to_assoc(assoc, record)
    return nil if assoc.options[:through]
    if assoc.macro == :belongs_to && assoc.options[:polymorphic]
      class_name = record.send(assoc.options[:foreign_type])
    else
      class_name = assoc.options[:class_name] || assoc.name.to_s.classify
    end
    model = arb_const_get(class_name)
    unless model.ancestors.include?(::ActiveRecord::Base)
      return nil
    end
    model_config = ActiveRecordBrowser::ModelConfig.find(model)
    label = "["
    label << h(model_config.human_name)
    if assoc.options[:class_name]
      label << "(#{h(assoc.name.to_s)})"
    end
    label << "] "

    case assoc.macro
    when :belongs_to
      search_params = []
      search_params << [model.primary_key, record.send(assoc.primary_key_name)]
      return arb_link_to_search_list(label, model, search_params)
    when :has_many, :has_one
      search_params = []
      search_params << [assoc.primary_key_name, record.send(@model.primary_key)]
      if polymorphic_name = assoc.options[:as]
        search_params << ["#{polymorphic_name}_type", record.class.name]
      end
      return arb_link_to_search_list(label, model, search_params)
    end
    return nil
  rescue => ex
    return content_tag(:div, h(ex.message)+":"+h(assoc.inspect))
  end

  def arb_association_links(record)
    links = []
    assocs = @model.reflect_on_all_associations.sort_by{|assoc|
      assoc.name.to_s
    }
    assocs.each do |assoc|
      if link = arb_link_to_assoc(assoc, record)
        links << link
      end
    end
    return links.join(' ')
  end

  def arb_link_to_delete(record)
    link_to("削除", {:action=>"destroy", :id=>record},
            {:confirm=>"本当に削除しますか？", :method=>:post})
  end

  def arb_delete_check_box(record)
    tag = ""
    tag << check_box_tag("delete[#{record.id}]", "1", record.deleted != 0)
    tag << hidden_field_tag("delete[#{record.id}]", "0")
    return tag
  end

  def arb_has_deleted_flag?
    @model.columns_hash["deleted"] ? true : false
  end
end
