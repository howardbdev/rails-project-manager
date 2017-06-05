class Note < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates :content, presence: true

  def time_created
    if self.created_at > Time.now.beginning_of_day
      "#{time_ago_in_words(self.created_at)} ago"
    else
      self.created_at.strftime("%b %d, %Y")
    end
  end

  def author
    User.where(id: self.user_id).first
  end

end
