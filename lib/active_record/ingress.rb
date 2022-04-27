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
end

ActiveSupport.on_load(:active_record) { include ActiveRecord::Ingress::Integration }
