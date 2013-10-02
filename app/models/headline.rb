class Headline < ActiveRecord::Base
  has_many :sentiment_data, :dependent => :destroy
  belongs_to :source
  validates :content, length: { in: 15..255 },
            uniqueness: true
  validates :date, presence: true
  validates :archive_url, presence: true

  validate :has_sentiment_data

  def has_sentiment_data
    errors.add(:headline, ":a headline must have sentiment data") if self.sentiment_data.empty?
  end

  def self.date(some_date) # returns all of the headlines that match that date
    search_date = DateTime.parse(some_date.to_s)
    date_range = search_date.beginning_of_day...search_date.end_of_day
    self.where(date: date_range)
  end

  def self.get_average(some_date, source_id)
    self.date(some_date).includes(:sentiment_data).average(:sentiment_score)
  end

  def self.get_average_cached(some_date, source_id)
    Rails.cache.fetch("avg_for_headline_by_day:#{source_id}:#{some_date.strftime("%Y%m%d")}") do
      self.get_average(some_date, source_id)
    end
  end
end
