require 'rails_helper'

RSpec.describe Assignment, type: :model do

  before do
    @user = create(:user)
    @project = create(:project)
    @assignment  = Assignment.create(user_id: @user.id, project_id: @project.id)
  end

  it 'belongs to a user and a project' do
    expect(@assignment.project_id && @assignment.user_id).to be_truthy
  end

end
