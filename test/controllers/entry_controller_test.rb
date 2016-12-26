require 'test_helper'

class EntryControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get entry_create_url
    assert_response :success
  end

end
