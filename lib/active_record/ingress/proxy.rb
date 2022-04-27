class ActiveRecord::Ingress::Proxy
  def initialize(record)
    @__record__ = record
  end

  def method_missing(name, ...)
    find_record_ingress_named(name).run(__record__, ...)
  end

  private
    attr_reader :__record__

    def find_record_ingress_named(name)
      "#{__record__.class.name}::Ingresses::#{name.to_s.classify}".constantize
    end
end
