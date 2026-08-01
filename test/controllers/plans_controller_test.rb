require "test_helper"

class PlansControllerTest < ActionDispatch::IntegrationTest
  test "owner creates plan" do
   sign_in_as(users(:alice))

   assert_difference("Plan.count") do
      post workspace_plans_path(workspaces(:wedding)),
            params: {
               plan: {
               title: "Reception"
            }
         }
      end
   end
end
