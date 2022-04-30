class ActiveRecord::Ingress::Base
  require_relative "base/callbacks"
  include Callbacks

  singleton_class.attr_reader :perform_with_params

  def initialize(record, params = {})
    @record, @params = record, params
  end

  def self.inherited(klass)
    if alias_name = klass.module_parent_name.chomp("::Ingresses").underscore.presence
      alias_method alias_name, :record
    end
  end

  def self.method_added(name)
    if name == :perform
      if instance_method(:perform).arity.nonzero?
        @perform_with_params = ->(params) { perform(**params.to_h) }
      else
        @perform_with_params = ->(params) { perform }
      end
    end
  end

  def self.run(...)
    new(...).run
  end

  def run
    run_callbacks :perform do
      instance_exec(params, &self.class.perform_with_params)
    end
  end

  private
    attr_reader :record, :params
    delegate :transaction, to: :record
end
