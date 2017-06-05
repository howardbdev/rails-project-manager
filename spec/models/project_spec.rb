require 'rails_helper'

RSpec.describe Project, type: :model do

  before do
    @worker = create(:user)
    @supervisor = create(:user, email: 'sup@sup.com', name: "Mr. Sup", role: 1)
    @admin = create(:user, email: 'admin@admin.com', name: "Big Cheese", role: 2)
  end

  it 'has an owner' do
    project = build(:project)
    project.owner = @worker
    project.save
    expect(@worker.pet_projects).to include(project)
    expect(project.owner).to be @worker
  end

end
