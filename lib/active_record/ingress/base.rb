class ActiveRecord::Ingress::Base
  include Callbacks, Transactions

  def initialize(record, params)
    @record, @params = record, params
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
