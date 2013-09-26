class Headline < ActiveRecord::Base
  belongs_to :source
  validates :content, length: { maximum: 250}
  validates :date, presence: true
  validates :archive_url, presence: true
end
