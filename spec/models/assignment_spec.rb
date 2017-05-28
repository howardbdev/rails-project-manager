require 'rails_helper'

RSpec.describe Assignment, type: :model do

  before do
    user1 = create(:user)
    user2 = create(:user, name: "Bob Two", role: 1)
  end

  it 'has a user_id and project_id' do
    assignment  = Assignment.create(user_id: 1, project_id: 1)
    expect(User.find_by(id: assignment.user_id)).to be_a User
    expect(assignment.project_id).not_to be nil
  end
end
