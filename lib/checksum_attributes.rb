require "checksum_attributes/version"
require "checksum_attributes/railtie" if defined?(Rails)
require "checksum_attributes/active_record/extension"

module ChecksumAttributes
  class Error < StandardError; end

  # Default digest type for checksum calculation
  DEFAULT_DIGEST_TYPE = :sha256

  # Available digest types
  DIGEST_TYPES = {
    sha1: OpenSSL::Digest::SHA1,
    sha256: OpenSSL::Digest::SHA256,
    sha384: OpenSSL::Digest::SHA384,
    sha512: OpenSSL::Digest::SHA512
  }.freeze

  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end

  class Configuration
    attr_accessor :default_digest_type, :attribute_delimiter

    def initialize
      @default_digest_type = ChecksumAttributes::DEFAULT_DIGEST_TYPE
      @attribute_delimiter = "|"
    end
  end
end 