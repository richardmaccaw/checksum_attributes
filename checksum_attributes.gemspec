Gem::Specification.new do |spec|
  spec.name          = "checksum_attributes"
  spec.version       = "0.1.0"
  spec.authors       = ["Richard Maccaw"]
  spec.email         = ["ricci6@gmail.com"]

  spec.summary       = "A gem for computing and verifying checksums on ActiveRecord model attributes"
  spec.description   = "ChecksumAttributes provides a mechanism for computing and verifying checksums on specified attributes of ActiveRecord models, helping ensure data integrity."
  spec.homepage      = "https://github.com/richardmaccaw/checksum_attributes"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.files = Dir.glob("{bin,lib}/**/*") + %w[README.md LICENSE.txt]
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 6.0.0"
  spec.add_dependency "activesupport", ">= 6.0.0"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "sqlite3", "~> 1.4"
  spec.add_development_dependency "pry", "~> 0.14"
end 