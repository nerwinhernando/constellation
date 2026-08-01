ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require_relative "test_helpers/session_test_helper"

Dir[Rails.root.join("test/support/**/*.rb")].sort.each do |file|
  require file
end

class ActiveSupport::TestCase
  fixtures :all
  parallelize(workers: :number_of_processors)
  include WorkspaceTestHelper
end

class ActionDispatch::IntegrationTest
  include AuthenticationTestHelper
  include AuthorizationTestHelper
  include WorkspaceTestHelper
end
