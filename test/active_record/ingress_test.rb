# frozen_string_literal: true

require "test_helper"

class ActiveRecord::IngressTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ActiveRecord::Ingress::VERSION
  end

  def test_it_does_something_useful
    assert false
  end
end
