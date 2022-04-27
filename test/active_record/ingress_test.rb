# frozen_string_literal: true

require "test_helper"

class ActiveRecord::IngressTest < Minitest::Test
  def setup
    super
    @post = Post.first
  end

  def test_that_it_has_a_version_number
    refute_nil ::ActiveRecord::Ingress::VERSION
  end

  def test_performs_update
    @post.ingressed.update
    assert_equal "Updated title", @post.title
  end
end
