module ChecksumAttributes
  class ChecksumAttribute < ::ActiveRecord::Base
    belongs_to :checksumable, polymorphic: true

    validates :checksum, presence: true
    validates :checksumable_type, presence: true
    validates :checksumable_id, presence: true, uniqueness: { scope: :checksumable_type }

    serialize :attribute_values, Hash
  end
end 