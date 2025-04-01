require "test_helper"
require "checksum_attributes"

class ChecksumAttributesTest < ActiveSupport::TestCase
  def setup
    @document = Document.create(
      title: "Test Document",
      content: "Test Content",
      author_id: 1
    )
  end

  test "calculates checksum correctly" do
    checksum = @document.calculate_checksum
    assert_not_nil checksum
    assert_kind_of String, checksum
  end

  test "sets and retrieves checksum" do
    assert @document.set_checksum
    assert_not_nil @document.checksum_attribute
    assert_equal @document.calculate_checksum, @document.checksum_attribute.checksum
  end

  test "validates checksum correctly" do
    @document.set_checksum
    assert @document.checksum_valid?

    @document.update(content: "Modified Content")
    refute @document.checksum_valid?
  end

  test "verify_or_set_checksum updates invalid checksum" do
    @document.set_checksum
    @document.update(content: "Modified Content")
    
    assert @document.verify_or_set_checksum
    assert @document.checksum_valid?
  end
end 