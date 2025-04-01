module ChecksumAttributes
  module ActiveRecord
    module Extension
      extend ActiveSupport::Concern

      included do
        has_one :checksum_attribute, as: :checksumable, dependent: :destroy
      end

      module ClassMethods
        def has_checksum_for(*attributes, digest_type: nil)
          @checksum_attributes = attributes
          @checksum_digest_type = digest_type || ChecksumAttributes.configuration.default_digest_type
        end

        def checksum_attributes
          @checksum_attributes || []
        end

        def checksum_digest_type
          @checksum_digest_type || ChecksumAttributes.configuration.default_digest_type
        end
      end

      def calculate_checksum
        return nil if self.class.checksum_attributes.empty?

        digest_class = ChecksumAttributes::DIGEST_TYPES[self.class.checksum_digest_type]
        digest = digest_class.new

        values = self.class.checksum_attributes.map do |attr|
          self.send(attr).to_s
        end

        digest.update(values.join(ChecksumAttributes.configuration.attribute_delimiter))
        digest.hexdigest
      end

      def set_checksum
        return false if self.class.checksum_attributes.empty?

        checksum = calculate_checksum
        return false unless checksum

        attribute_values = self.class.checksum_attributes.each_with_object({}) do |attr, hash|
          hash[attr] = self.send(attr)
        end

        checksum_attr = self.checksum_attribute || self.build_checksum_attribute
        checksum_attr.update!(
          checksum: checksum,
          attribute_values: attribute_values
        )
      end

      def checksum_valid?
        return true if self.class.checksum_attributes.empty?
        return false unless checksum_attribute

        current_checksum = calculate_checksum
        current_checksum == checksum_attribute.checksum
      end

      def verify_or_set_checksum
        if checksum_valid?
          true
        else
          set_checksum
        end
      end
    end
  end
end

ActiveSupport.on_load(:active_record) do
  extend ChecksumAttributes::ActiveRecord::Extension
end 