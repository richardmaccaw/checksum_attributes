class CreateChecksumAttributes < ActiveRecord::Migration[6.0]
  def change
    create_table :checksum_attributes do |t|
      t.references :checksumable, polymorphic: true, null: false
      t.string :checksum, null: false
      t.text :attribute_values
      t.timestamps
    end

    add_index :checksum_attributes, [:checksumable_type, :checksumable_id], unique: true
  end
end 