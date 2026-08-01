# frozen_string_literal: true

module AuthorizationTestHelper
  def assert_forbidden
    assert_response :forbidden
  end

  def assert_not_found
    assert_response :not_found
  end

  def assert_unprocessable
    assert_response :unprocessable_entity
  end
end
