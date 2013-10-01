class Source < ActiveRecord::Base
  has_many :headlines, :dependent => :destroy
  validates :name, presence: true, uniqueness: true

  def get_average_for_date(some_date)
    self.headlines.get_average(some_date)
  end

  def get_average_for_date_cached(some_date)
    Rails.cache.fetch("avg_for_source_by_day:#{self.id}:#{some_date.strftime("%Y%m%d")}") do
      self.get_average_for_date(some_date)
    end
  end

  def uncache_average_for_date(some_date)
    Rails.cache.delete("avg_for_source_by_day:#{self.id}:#{some_date.strftime("%Y%m%d")}")
  end
end
