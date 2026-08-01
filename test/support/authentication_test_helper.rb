# frozen_string_literal: true

module AuthenticationTestHelper
  def sign_in_as(user)
    post session_path, params: {
      email: user.email,
      password: "TEST_PASSWORD"
    }

    follow_redirect!
  end

  def sign_out
    delete session_path

    follow_redirect!
  end

  def assert_requires_authentication
    assert_redirected_to new_session_path
  end
end
