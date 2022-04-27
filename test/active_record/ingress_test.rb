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

  def test_passes_argument_to_ingressed_update
    @post.ingressed.update(title: "Updated title")
    assert_equal "Updated title", @post.title
  end

  def test_performs_destroy
    @post.ingressed.destroy
    assert_empty Post.all
  end

  def test_aborts_action_through_ingress
    old_abort, Post::Ingresses::Destroy.abort = Post::Ingresses::Destroy.abort, true

    @post.ingressed.destroy
    refute_predicate @post, :destroyed?
    refure_empty Post.all
  ensure
    Post::Ingresses::Destroy.abort = old_abort
  end
end
