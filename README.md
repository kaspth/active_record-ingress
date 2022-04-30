# ActiveRecord::Ingress

Pass control of Active Record methods to a dedicated object.

## Usage

`ActiveRecord::Ingress` adds proxy forwarding method `ingressed` to any `ActiveRecord::Base` instance.

So `post.ingressed.update(title: "Updated title")` would look up a `Post::Ingressed::Update` class, instance and execute its `perform` method:

```ruby
# app/models/post/ingressed/update.rb
class Post::Ingressed::Update < ActiveRecord::Ingress::Base
  # Each ingress has `params`, containing any passed keyword arguments.
  # This extracts `params[:title]` and Ruby's keyword arguments handling will prevent accepting other arguments.
  def perform(title:)
    post.update(title: title)
  end
end
```

Ingresses can be used to create other forwarding too. Here, a `post.ingressed.prepare` is added:

```ruby
# app/models/post/ingressed/prepare.rb
class Post::Ingressed::Publish < ActiveRecord::Ingress::Base
  def perform
    # Forwards to `record.transaction`
    transaction do
      post.published!
      Post::Promotions.recognize_recently_published post
    end
  end
end
```

It's also possible to annotate an ingress on the model side so it's always used:

```ruby
class Post < ActiveRecord::Base
  ingressed :publish # defines `publish` that delegates to `ingressed.publish`
end
```

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add active_record-ingress

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install active_record-ingress

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kaspth/active_record-ingress.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
