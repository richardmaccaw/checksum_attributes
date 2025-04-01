# ChecksumAttributes

> **Development Status**: This gem is currently in active development and its API may change before the first stable release. Use at your own risk.

A Ruby gem that provides a mechanism for computing and verifying checksums on specified attributes of ActiveRecord models.

## Features

- Declare which attributes should be checksummed in your models
- Automatic checksum calculation and storage
- Verification of data integrity
- Support for multiple digest algorithms (SHA-1, SHA-256, SHA-384, SHA-512)
- Polymorphic storage of checksums
- Rails generator for easy installation

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'checksum_attributes'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install checksum_attributes
```

## Usage

### Installation

Run the generator to create the necessary migration:

```bash
rails generate checksum_attributes:install
```

Then run the migration:

```bash
rails db:migrate
```

### In Your Models

Include the checksum functionality in your model:

```ruby
class Document < ApplicationRecord
  include ChecksumAttributes::HasChecksum
  has_checksum_for :title, :content, :author_id, digest_type: :sha256
end
```

### Available Methods

```ruby
# Calculate the current checksum (doesn't persist)
document.calculate_checksum

# Set/update the checksum in storage
document.set_checksum

# Check if the current attributes match the stored checksum
document.checksum_valid?

# Verify and update checksum if needed
document.verify_or_set_checksum
```

### Configuration

You can configure the gem in an initializer:

```ruby
# config/initializers/checksum_attributes.rb
ChecksumAttributes.configure do |config|
  config.default_digest_type = :sha256  # Default is :sha256
  config.attribute_delimiter = "|"      # Default is "|"
end
```

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake test` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub.

## License

The gem is available as open source under the terms of the MIT License. 
