require "csv"

module ActiveRecordBrowser::CsvHandler
  def arb_import_from_csv(stream, options={})
    max_at_once = options[:max_at_once] || 100
    header_spec = options[:header_spec] || []
    unless header_spec.empty?
      columns_to_insert = arb_collect_columns(header_spec)
      columns_spec = arb_make_columns_spec(columns_to_insert)
    end

    count = 0
    rows = []
    ::CSV::Reader.parse(stream, options[:fs], options[:rs]).each do |row|
      unless columns_to_insert
        columns_to_insert = arb_collect_columns(row)
        columns_spec = arb_make_columns_spec(columns_to_insert)
        next
      end

      values = []
      columns_to_insert.zip(row) do |column, value|
        if column
          values << quote_value(value, column)
        end
      end
      rows << values

      if rows.length >= max_at_once
        arb_insert_data(columns_spec, rows)
        count += rows.length
        rows.clear
      end
    end
    arb_insert_data(columns_spec, rows) unless rows.blank?
    return count + rows.length
  end

  def arb_export_to_csv(stream, options={})
    fs = options.delete(:col_sep)
    rs = options.delete(:row_sep)
    except_column_types = [options[:except_column_types]].flatten.compact
    columns_to_export = options[:include_system_key] ? columns : content_columns
    columns_to_export = columns_to_export.select do |column|
      not except_column_types.include?(column.type)
    end
    columns_to_export.sort_by(&:name)
    ::CSV::Writer.generate(stream, fs, rs) do |writer|
      writer << columns_to_export.collect(&:name)
      find(:all, :order=>"#{primary_key} ASC").each do |record|
        row = columns_to_export.collect do |column|
          arb_time_to_string(record.send(column.name), column)
        end
        writer << row
      end
    end
    return stream
  end

  def arb_clean_table(flush=true)
    case adapter = configurations[RAILS_ENV]["adapter"]
    when "mysql"
      delete_sql = "DELETE IGNORE FROM %s"
      flush_sql = "ALTER TABLE %s AUTO_INCREMENT=1;"
    else
      raise "adapter #{adapter} not supported"
      return false
    end
    connection.delete(sprintf(delete_sql, table_name))
    connection.execute(sprintf(flush_sql, table_name)) if flush
    return true
  end

  private

  def arb_insert_data(columns_spec, rows)
    values = rows.collect{|row| "(#{row.join(",")})" }
    sql = "INSERT INTO #{table_name} (#{columns_spec}) VALUES "
    sql << values.join(",")
    connection.execute(sql)
  end

  def arb_collect_columns(header_spec)
    return header_spec.collect{|name| columns_hash[name.to_s.strip] }
  end

  def arb_make_columns_spec(columns)
    column_names = columns.compact.collect{|c|
      connection.quote_column_name(c.name) }
    return column_names.join(", ")
  end

  def arb_time_to_string(value, column)
    return nil if value.nil?
    case column.type
    when :datetime, :timestamp
      value.strftime("%F %H:%M:%S")
    when :time
      value.strftime("%H:%M:%S")
    when :date
      value.strftime("%F")
    else
      value
    end
  end
end
