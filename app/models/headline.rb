class Headline < ActiveRecord::Base
  belongs_to :source
  validates :content, length: { maximum: 255}
  validates :date, presence: true
  validates :archive_url, presence: true
  validates :sentiment_engine, :inclusion => { :in => %w(Alchemy ViralHeat
                                                  Sentimental Sentimentalizer)}
end
