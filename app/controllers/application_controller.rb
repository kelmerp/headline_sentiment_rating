class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # def grab_average(source)
  #   dates = []
  #   json_object = []

  #   source = Source.find_by(name: source)
  #   dates = source.headlines.order("date DESC").pluck(:date).uniq

  #   dates.each do |date|
  #     object = {date: DateTime.parse(date.to_s).to_i, score: source.get_average_for_date_cached(date, source.id).to_f, source: source.name }
  #     json_object << object
  #   end
  #   json_object
  # end

  # def grab_average_cached(source)
  #   Rails.cache.fetch("cached info for#{source}") do
  #     self.grab_average(source)
  #   end
  # end

  protect_from_forgery with: :exception
end
