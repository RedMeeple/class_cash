require 'test_helper'
require 'students_controller.rb'

class StudentsController <  ApplicationController
  def logged_in?
    true
  end
end

class StudentsControllerTest < ActionController::TestCase
  setup do
    @student = students(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:students)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create student" do
    assert_difference('Student.count') do
      post :create, student: { cash: @student.cash, email: @student.email, first_name: @student.first_name, good_behevior: @student.good_behevior, last_name: @student.last_name, password: "password", period_id: @student.period_id, richest: @student.richest }
    end

    assert_redirected_to student_path(assigns(:student))
  end

  test "should show student" do
    get :show, id: @student
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @student
    assert_response :success
  end

  test "should update student" do
    patch :update, id: @student, student: { cash: @student.cash, email: @student.email, first_name: @student.first_name, good_behevior: @student.good_behevior, last_name: @student.last_name, password_digest: @student.password_digest, period_id: @student.period_id, richest: @student.richest }
    assert_redirected_to student_path(assigns(:student))
  end

  test "should destroy student" do
    assert_difference('Student.count', -1) do
      delete :destroy, id: @student
    end

    assert_redirected_to students_path
  end
end
