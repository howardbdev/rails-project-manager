class Note < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates :content, presence: true

  def time_created
    if message.created_at > Time.now.beginning_of_day
      "#{time_ago_in_words(message.created_at)} ago"
    else
        <%= message.created_at.strftime("%b %d, %Y")
    end

  end

end
