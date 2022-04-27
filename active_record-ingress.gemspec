# frozen_string_literal: true

require_relative "lib/active_record/ingress/version"

Gem::Specification.new do |spec|
  spec.name    = "active_record-ingress"
  spec.version = ActiveRecord::Ingress::VERSION
  spec.authors = ["Kasper Timm Hansen"]
  spec.email   = ["hey@kaspth.com"]

  spec.summary  = "Pass control of Active Record methods to a dedicated object."
  spec.homepage = "https://github.com/kaspth/active_record-ingress"
  spec.license  = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"]   = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 6.1"
end
