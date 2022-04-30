# frozen_string_literal: true

require "test_helper"

class ActiveRecord::IngressTest < ActiveSupport::TestCase
  setup { @post = Post.first }

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
    old_abort, Post::Ingressed::Destroy.abort = Post::Ingressed::Destroy.abort, true

    @post.ingressed.destroy
    refute_predicate @post, :destroyed?
    refute_empty Post.all
  ensure
    Post::Ingressed::Destroy.abort = old_abort
  end

  def test_ingressed_extension
    old_published_onto, Post::Ingressed::Publish.published_onto = Post::Ingressed::Publish.published_onto, true

    @post.publish(onto: :somewhere)
    assert_equal :somewhere, Post::Ingressed::Publish.published_onto
  ensure
    Post::Ingressed::Publish.published_onto = old_published_onto
  end
end
