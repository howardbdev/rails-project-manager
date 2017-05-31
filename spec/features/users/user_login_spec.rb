require 'rails_helper'

describe "get /login" do
  before do
    @user = create(:user)
  end

  it "has a link to sign up" do
    visit '/'
    click_link 'Sign Up'
    expect(page).to have_content("Welcome.  Please Sign Up Here!")
  end

  it 'allows a valid user to log in' do
    visit login_path
    fill_in('email', with: @user.email)
    fill_in('password', with: @user.password)
    click_button 'Log In'
    expect(session[:user_id]).to eq @user.id
  end
end
