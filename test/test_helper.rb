# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "active_record"
require "active_record/ingress"

require "minitest/autorun"

require_relative "boot/active_record"

author = Author.create!
author.posts.create! title: "First post"

module Post::Ingresses; end # Zeitwerk handles this in Rails

class Post::Ingresses::Update < ActiveRecord::Ingress::Base
  def perform
    post.update title: "Updated title"
  end
end
