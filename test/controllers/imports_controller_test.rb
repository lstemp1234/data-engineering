require 'test_helper'

class ImportsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test 'should process uploaded file' do
    post :create, data: fixture_file_upload('files/example.tsv', 'text/tsv')
    assert_response :success

    assert_not_nil assigns(:gross_revenue)
  end

  test 'should fail to process a mis-formatted file' do
    post :create, data: fixture_file_upload('files/example.csv', 'text/csv')
    assert_redirected_to imports_path

    assert_not assigns(:gross_revenue)
  end
end
