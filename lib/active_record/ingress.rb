# frozen_string_literal: true

require_relative "ingress/version"

module ActiveRecord::Ingress
  autoload :Base,  "active_record/ingress/base"
  autoload :Proxy, "active_record/ingress/proxy"

  module Integration
    def ingressed
      Proxy.new(self)
    end
  end

  module Extension
    def ingressed(*names)
      delegate *names, to: :ingressed
    end
  end
end

ActiveSupport.on_load(:active_record) do
  include ActiveRecord::Ingress::Integration
  extend  ActiveRecord::Ingress::Extension
end
