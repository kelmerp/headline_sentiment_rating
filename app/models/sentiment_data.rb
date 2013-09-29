class SentimentData < ActiveRecord::Base
  belongs_to :headline
  validates :sentiment_score, presence: true
  validates :sentiment_engine, :inclusion => { :in => %w(Alchemy ViralHeat
                                                  Sentimental Sentimentalizer)}
end
