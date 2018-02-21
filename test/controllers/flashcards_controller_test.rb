require "test_helper"

class FlashcardsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get flashcards_new_url
    assert_response :success
  end

  test "should get edit" do
    get flashcards_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get flashcards_destroy_url
    assert_response :success
  end

end
