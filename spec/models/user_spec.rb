require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @worker = build(:user)
    @supervisor = build(:user, name: "Mr. Sup", role: 1)
    @admin = build(:user, name: "Big Cheese", role: 2)
  end

  it 'is not valid without a name' do
    no_name = build(:user, name: nil)
    expect(no_name.valid?).to eq false
  end

  it 'is not valid without a password' do
    no_password = build(:user, password: nil)
    expect(no_password.valid?).to eq false
  end

  it 'is not valid without an email' do
    no_email = build(:user, email: nil)
    expect(no_email.valid?).to eq false
  end

  it 'is valid with name, email, and password' do
    expect(@worker.valid?).to be true
    expect(@worker.save).to eq true
  end

end
