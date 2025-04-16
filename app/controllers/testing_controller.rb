class TestingController < ApplicationController
  if Rails.env.development? || Rails.env.test?
    skip_before_action :verify_authenticity_token  # important for Cypress
    def reset_test_users_registered
      User.where("email LIKE ?", "test@email.com").delete_all
      head :ok
    end
  else
    head :forbidden
  end
end
