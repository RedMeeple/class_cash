require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  test "successful login" do
    get sessions_login_path
    assert_select "input[type=password]", 1
    post sessions_login_path, password: "password", email: "teach@er.com"
    assert_redirected_to dashboard_instructor_path

    follow_redirect!
    assert response.body.match("Welcome")
    #assert_select ".parent-table" to test if a table pops up on new page
    #number_of_parents = css_select("tbody tr").count to test how many are in table
    #get new_parent_path
    #assert_response :success
    #post parents_path, parent: {name: "name", email: "email", student: "name"}
    #assert_redirected_to parents_path

    #follow_redirect!
    #assert number_of_parents + 1, css_select("tbody tr").count

    assert_select "a[href='#{sessions_logout_path}']", 1

    get sessions_logout_path
    assert_redirected_to sessions_login_path
    follow_redirect!
    assert_select "input[type=password]", 1
  end
end
