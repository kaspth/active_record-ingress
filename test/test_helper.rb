# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "active_record"
require "active_record/ingress"

require "minitest/autorun"

require_relative "boot/active_record"

author = Author.create!
author.posts.create! title: "First post"

ActiveSupport.on_load(:active_support_test_case) { include ActiveRecord::TestFixtures }

module Post::Ingressed; end # Zeitwerk handles this in Rails

class Post::Ingressed::Publish < ActiveRecord::Ingress::Base
  mattr_accessor :published_onto

  def perform(onto:)
    self.published_onto = onto
  end
end

class Post::Ingressed::Update < ActiveRecord::Ingress::Base
  def perform(title:)
    post.update(title: title)
  end
end

class Post::Ingressed::Destroy < ActiveRecord::Ingress::Base
  mattr_accessor :abort, default: false

  before_perform { throw :abort if abort }

  def perform
    post.destroy!
  end
end
