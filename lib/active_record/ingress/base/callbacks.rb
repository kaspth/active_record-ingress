module ActiveRecord::Ingress::Base::Callbacks
  extend  ActiveSupport::Concern
  include ActiveSupport::Callbacks

  included do
    define_callbacks :perform
  end

  class_methods do
    def before_perform(...)
      set_callback(:perform, :before, ...)
    end

    def after_perform(...)
      set_callback(:perform, :after, ...)
    end

    def around_perform(...)
      set_callback(:perform, :around, ...)
    end
  end
end
