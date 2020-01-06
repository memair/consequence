class Goal < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true

  validates :name, presence: true
  validates :query, presence: true
  validates :mapping, presence: true
  validates :trigger_calculation, presence: true
  validates :trigger_type, presence: true
  validates :trigger_value, presence: true
  validates :troll_twitter_id, presence: true

  def troll
    Troll.find_by(twitter_id: self.troll_twitter_id)
  end
end
