# frozen_string_literal: true

require "test_helper"

class AuthenticationSmokeTest < ActionDispatch::IntegrationTest
  test "owner can sign in" do
    sign_in_as(owner)

    assert_response :success
  end

  test "owner can sign out" do
    sign_in_as(owner)

    sign_out

    assert_response :success
  end
end
