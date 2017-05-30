require 'rails_helper'

RSpec.describe Assignment, type: :model do

  before do
    @user1 = create(:user)
    @user2 = create(:user, name: "Bob Two", role: 1)
    @assignment  = Assignment.new(user_id: 1, project_id: 1)
    @project = create(:project)
  end

  it 'has a user_id and project_id' do
    expect(User.find_by(id: @assignment.user_id)).to be_a User
    expect(@assignment.project_id).not_to be nil
  end

  it 'is invalid without a valid project and user' do
    @assignment.update(project_id: 3)
    expect(@assignment.valid?).to be false
  end

  it 'is valid with a valid project and user' do
    expect(@assignment.valid? && @assignment.save).to be true
  end

  it 'populates user project list' do
    4.times do
      Assignment.create(user_id: 1, project_id: 1)
    end
    expect(@user1.projects.count).to eq(4)
  end
end
