ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Schema.define do
  create_table :authors, force: true do |t|
  end

  create_table :posts, force: true do |t|
    t.string :title
    t.integer :author_id
  end
end

# Shim what an app integration would look like.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class Author < ApplicationRecord
  has_many :posts
end

class Post < ApplicationRecord
  belongs_to :author

  ingressed :publish
end
