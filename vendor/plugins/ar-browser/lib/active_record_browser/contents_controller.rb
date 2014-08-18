require File.expand_path("application", File.dirname(__FILE__))
require "stringio"
require "csv"

class  ActiveRecordBrowser::ContentsController < ActiveRecordBrowser::ApplicationController
  verify :method=>:post, :only =>%w(destroy create update),
         :redirect_to =>{:action=>:list}
  before_filter :find_model, :except=>%w(services)
  before_filter :load_config, :except=>%w(services)
  before_filter :check_importable, :only=>%w(import)
  before_filter :check_editable, :only=>%w(new create edit update destroy)

  def services
    @arb_top = true
    model_configs = ActiveRecordBrowser::ModelConfig.find(:all)
    if model_configs.blank?
      tables = ActiveRecord::Base.connection.tables
      models = tables.collect do |table_name|
        class_name = table_name.classify
        Object.const_get(class_name) rescue nil
      end
      @model_names = models.compact.collect do |model|
        {:name=>model.name, :human_name=>model.name}
      end
    else
      @model_names = model_configs.collect do |config|
        {:name=>config.model.name, :human_name=>config.human_name}
      end
    end
    @model_names = @model_names.sort_by{|m| m[:name]}
    render_scaffold("services")
  end

  def index
    list
  end

  def list
    if params[:search_query] && params[:search_column]
      @page_params = {:search_column=>params[:search_column], :search_query=>params[:search_query],}
    end
    @columns = model.columns.reject{|col| col.name == "deleted" }
    @select_column_items = search_columns.collect{|column| [column.name, column.name]}
    @records = model.paginate({
      :page=>params[:page], :per_page=>50, :conditions=>setup_search_conditions,
      :order=>setup_sort_order,
    })
    @total = model.count(:conditions=>setup_search_conditions)
    @from = @records.offset + 1
    @to = @records.offset + @records.size
    render_scaffold("list")
  end

  def show
    @columns = model.columns
    @record = model.find(params[:id])
    render_scaffold
  end

  def destroy
    model.find(params[:id]).destroy
    redirect_to(:action=>"list")
  end

  def new
    @record = model.new
    render_scaffold
  end

  def create
    @record = model.new(params[:record])
    if @record.save
      flash[:notice] = "モデルを作成しました。"
      redirect_to(:action=>"list")
    else
      render_scaffold('new')
    end
  end

  def edit
    @record = model.find(params[:id])
    render_scaffold
  end

  def update
    @record = model.find(params[:id])
    @record.attributes = params[:record]

    if @record.save
      flash[:notice] = "モデルを更新しました。"
      redirect_to(:action=>"show", :id=>@record)
    else
      render_scaffold('edit')
    end
  end

  def update_all
    checked, unchecked = params[:delete].partition{|id, value| value.to_i==1 }
    deleted_at = @model.columns_hash["deleted_at"]
    primary_key = @model.primary_key
    @model.update_all(
      deleted_at ? "deleted = 1, deleted_at = NOW()" : "deleted = 1",
      ["#{primary_key} IN (?) AND deleted <> 1", checked.collect{|id,_| id }]
    )
    @model.update_all(
      deleted_at ? "deleted = 0, deleted_at = NULL" : "deleted = 0",
      ["#{primary_key} IN (?) AND deleted <> 0", unchecked.collect{|id,_| id }]
    )
    redirect_to :action=>"index"
  end

  def import
    load_file = params[:load_file]
    unless ! load_file.blank? && csv_filename?(load_file.original_filename)
      flash[:notice] = "CSVファイルを指定してください。"
      redirect_to(:action=>"list")
      return
    end

    begin
      @model.transaction do
        @model.arb_clean_table if params[:save_method] == "overwrite"
        @model.arb_import_from_csv(load_file)
      end
      flash[:notice] = "CSVファイルからデータを追加しました。"
    rescue CSV::IllegalFormatError
      flash[:notice] = "CSVファイルからデータを追加できませんでした。フォーマットを確認してください。"
    end
    redirect_to(:action=>"list")
  end

  def export
    csv_file = @model.arb_export_to_csv(StringIO.new, {
      :col_sep=>",", :row_sep=>"\r\n",
      :except_column_types=>[:binary, :longblob],
      :include_system_key=>true,
    })
    send_data(csv_file.string, :type=>"text/csv", :filename=>"#{@model.table_name}.csv")
    csv_file.close
  end

  private

  def controller_path
    path = ActiveRecordBrowser::ADMIN_ROOT
    path += "/#{model.name.pluralize.downcase}" unless params[:action] == "services"
    path
  end

  def model
    names = params[:model].split("::")
    names.inject(Object){|klass, name| klass.const_get(name.classify) }
  end

  def find_model
    @model = model
  rescue NameError
    flash[:notice] = "#{params[:model]}は存在しません。"
    redirect_to :action=>"services"
  end

  def default_url_options(options)
    return {} if options[:action].to_s == "services"
    return {:model=>params[:model]}
  end
 
  def csv_filename?(filename)
    File.extname(filename) == '.csv'
  end

  def load_config
    @config = config
  end

  def config
    config = ActiveRecordBrowser::ModelConfig.find(model)
  end
  helper_method :config
  
  def check_importable
    unless config.importable
      redirect_to(:action=>"list")
    end
  end
  
  def check_editable
    unless config.editable
      redirect_to(:action=>"list")
    end
  end

  def setup_sort_order
    params[:sort] = @model.primary_key unless @model.column_names.include?(params[:sort])
    params[:order] = "asc" unless ["asc", "desc"].include?(params[:order])
    return "#{@model.table_name}.#{params[:sort]} #{params[:order]}"
  end

  def setup_search_condition(name, value)
    if column = @model.columns_hash[name]
      case column.type
      when :string, :text
        return ["#{@model.table_name}.#{name} like ?", "%#{value}%"]
      when :integer, :float
        return ["#{@model.table_name}.#{name} = ?", value]
      end
    end
    return nil
  end

  def setup_search_conditions
    n = 0
    statements = []
    values = []
    while true
      name = params["search_column_#{n}"]
      value = params["search_query_#{n}"]
      unless condition = setup_search_condition(name, value)
        break
      end
      statements << condition.shift
      values.concat(condition)
      n += 1
    end
    return [statements.join(" AND "), *values]
  end

  def search_columns
    @model.columns.select{|column|
      [:string, :text, :integer, :float].include?(column.type)
    }
  end
end
