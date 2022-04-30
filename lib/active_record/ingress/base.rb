class ActiveRecord::Ingress::Base
  require_relative "base/callbacks"
  include Callbacks

  require_relative "base/transactions"
  include Transactions # Depends on Callbacks

  def initialize(record, params = {})
    @record, @params = record, params
  end

  def self.inherited(klass)
    if alias_name = klass.module_parent_name.chomp("::Ingresses").underscore.presence
      alias_method alias_name, :record
    end
  end

  def self.run(...)
    new(...).run
  end

  def run
    run_callbacks :perform do
      perform
    end
  end

  private
    attr_reader :record, :params
end
