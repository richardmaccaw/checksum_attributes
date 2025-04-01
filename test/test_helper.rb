require "active_record"
require "minitest/autorun"
require "checksum_attributes"

# Set up test database
ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ":memory:"
)

# Create test model
class Document < ActiveRecord::Base
  has_checksum_for :title, :content, :author_id
end

# Create tables
ActiveRecord::Schema.define do
  create_table :documents do |t|
    t.string :title
    t.text :content
    t.integer :author_id
    t.timestamps
  end
end

# Run migrations
ChecksumAttributes::Generators::InstallGenerator.new.create_migration
ActiveRecord::Migration.run(:up) 