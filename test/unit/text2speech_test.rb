require 'test_helper'

class Text2speechTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Speech.new.valid?
  end
end
