require 'test_helper'
require 'dashboard_controller.rb'

class DashboardController <  ApplicationController
  def instructor_logged_in?
    true
  end

  def student_logged_in?
    true
  end
end

class DashboardControllerTest < ActionController::TestCase
  test "should get student" do
    get :student
    assert_response :success
  end

  test "should get instructor" do
    get :instructor
    assert_response :success
  end

end
