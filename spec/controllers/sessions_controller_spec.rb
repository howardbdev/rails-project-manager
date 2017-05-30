require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  include Capybara::DSL

  describe "get /login" do
    it "has a link to sign up" do
      visit '/'
      click_link 'Sign Up'
      expect(page).to have_content("Welcome.  Please Sign Up Here!")
    end
  end
end
