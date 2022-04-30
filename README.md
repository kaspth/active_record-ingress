# ActiveRecord::Ingress

Pass control of Active Record methods to a dedicated object.

## Usage

`post.ingressed.update(title: "Updated title")` and `post.ingressed.destroy`

```ruby
# app/models/post/ingresses/update.rb
class Post::Ingresses::Update < ActiveRecord::Ingress::Base
  def perform
    record.update title: params[:title]
  end
end

# app/models/post/ingresses/destroy.rb
class Post::Ingresses::Destroy < ActiveRecord::Ingress::Base
  def perform
    record.destroy!
  end
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
