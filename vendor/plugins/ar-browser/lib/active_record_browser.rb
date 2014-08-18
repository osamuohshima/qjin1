module ActiveRecordBrowser
  VERSION = "1.0.0"
  CONFIG = {
    :application_name=>"Active Record Browser",
    :models=>[],
  }
  ADMIN_ROOT = defined?(::ACTIVE_RECORD_BROWSER_ROOT) ?
    ::ACTIVE_RECORD_BROWSER_ROOT : "/admin"

  class << self
    def load_config(config)
      CONFIG.update(config)
    end

    def application_name
      return CONFIG[:application_name]
    end
  end

  class ModelConfig
    attr_reader :model, :human_name, :importable, :editable

    def initialize(args)
      @model = args[:model]
      @human_name = args[:human_name] || @model.name
      @importable = args.has_key?(:importable) ? args[:importable] : true
      @editable   = args.has_key?(:editable) ? args[:editable] : true
    end

    class << self
      def load_config(model_configs)
        configs = model_configs.inject({}) do |tmp, config|
          tmp[config[:model].name] = ModelConfig.new(config)
          tmp
        end
        return configs
      end

      def list
        return @list ||= load_config(ActiveRecordBrowser::CONFIG[:models])
      end

      def find(*args)
        case first_arg = args.first
        when :all
          return list.collect{|k, v| v}
        else
          unless config = list[first_arg.name]
            config = ModelConfig.new(:model=>first_arg)
          end
          return config
        end
      end
    end
  end
end
