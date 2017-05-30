require 'rails_helper'

describe "get /login" do
  it "has a link to sign up" do
    visit '/'
    click_link 'Sign Up'
    expect(page).to have_content("Welcome.  Please Sign Up Here!")
  end
end
