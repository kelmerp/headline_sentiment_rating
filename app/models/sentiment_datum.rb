class SentimentDatum < ActiveRecord::Base
  belongs_to :headline, :dependent => :destroy
  validates :sentiment_score, presence: true
  validates :sentiment_engine, :inclusion => { :in => %w(Alchemy ViralHeat
                                                  Sentimental Sentimentalizer)}
  validates :sentiment_engine, :uniqueness => { :scope => :headline_id,
            :message => "only one score per engine" }
end
