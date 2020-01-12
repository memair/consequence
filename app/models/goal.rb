class Goal < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true

  validates :name, presence: true
  validates :query, presence: true
  validates :mapping, presence: true
  validates :trigger_calculation, inclusion: { in: ['==', '!=', '>=', '>', '<=', '<'] }
  validates :trigger_type, inclusion: { in: ['count', 'sum', 'avg'] }
  validates :trigger_value, presence: true, numericality: true
  validates :troll_twitter_id, presence: true

  def troll
    Troll.find_by(twitter_id: self.troll_twitter_id)
  end

  def failed?
    user = Memair.new(self.user.memair_access_token)
    response = user.query(self.query)
    raise ArgumentError, "errors in query" if response.keys.include?('errors')
    map = self.mapping.split(',').map(&:strip)

    begin
      mapped_results = response
      map.each { |m| mapped_results = mapped_results[m] }
    rescue NoMethodError
      raise ArgumentError, "error in mapping"
    end

    raise ArgumentError, "error in mapping" if mapped_results.nil? 

    if self.trigger_type == 'count' && mapped_results.class == Array
      count = mapped_results.count

      return eval("#{count} #{self.trigger_calculation} #{self.trigger_value}")
    else
      raise ArgumentError, "not yet implemented"
    end
  end
end
