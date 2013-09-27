class Headline < ActiveRecord::Base
  belongs_to :source
  validates :content, length: { maximum: 255}
  validates :date, presence: true
  validates :archive_url, presence: true
  validates :sentiment_score, presence: true
  validates :sentiment_engine, :inclusion => { :in => %w(Alchemy ViralHeat
                                                  Sentimental Sentimentalizer)}
  def self.date(some_date)
    search_date = DateTime.parse(some_date.to_s)
    date_range = search_date.beginning_of_day...search_date.end_of_day
    self.where(date: date_range)
  end

  def self.get_average(some_date)
    self.date(some_date).average(:sentiment_score)
  end
end
