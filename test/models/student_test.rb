require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  setup do
    @student = students(:two)
  end

  test "richest?" do
    Student.richest?

    assert @student.richest
    refute students(:one).richest
  end
end
