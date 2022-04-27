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
    record.update params.slice(:title)
  end
end

class Post::Ingresses::Destroy < ActiveRecord::Ingress::Base
  mattr_accessor :abort, default: false

  before_perform { throw :abort if abort }

  def perform
    record.destroy!
  end
end
