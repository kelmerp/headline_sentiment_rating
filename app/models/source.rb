class Source < ActiveRecord::Base
  has_many :headlines, :dependent => :destroy
  validates :name, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true

  def get_average_for_date(some_date, source_id)
    Headline.get_average_cached(some_date, source_id)
  end

  def get_average_for_date_cached(some_date, source_id)
    Rails.cache.fetch("avg_for_source_by_day:#{self.id}:#{some_date.strftime("%Y%m%d")}") do
      get_average_for_date(some_date, source_id)
    end
  end

  def uncache_average_for_date(some_date)
    Rails.cache.delete("avg_for_source_by_day:#{self.id}:#{some_date.strftime("%Y%m%d")}")
  end

  def self.get_all
    source_array = []
    Source.all.find_each do |source|
      source_array << self.grab_average_cached(source.name)
    end
    source_array
  end

  def self.get_all_cached
    Rails.cache.fetch("all_source_data") do
      self.get_all
    end
  end

  def self.grab_average(source)
    dates = []
    json_object = []

    source = Source.find_by(name: source)
    dates = source.headlines.order("date DESC").pluck(:date).uniq

    dates.each do |date|
      object = {date: DateTime.parse(date.to_s).to_i, score: source.get_average_for_date_cached(date, source.id).to_f, source: source.name }
      json_object << object
    end
    json_object
  end

  def self.grab_average_cached(source)
    Rails.cache.fetch("cached info for#{source}") do
      self.grab_average(source)
    end
  end
end
