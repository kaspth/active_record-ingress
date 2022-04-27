module ActiveRecord::Ingress::Base::Transactions
  extend ActiveSupport::Concern

  included do
    delegate :transaction, to: :record
    around_perform :transaction
  end

  class_methods do
    def skip_transaction
      skip_callback :perform, :around, :transaction
    end
  end
end
