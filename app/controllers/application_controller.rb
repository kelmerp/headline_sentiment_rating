class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  def grab_average(source)
    dates = []
    json_object = []

    source = Source.find_by(name: source)
    dates = source.headlines.pluck(:date).uniq!

    dates.sort.reverse.each do |date|
      object = {date: DateTime.parse(date.to_s).to_i, score: source.get_average_for_date_cached(date).to_f, source: source.name.split('.')[1] }
      json_object << object
    end
    json_object
  end

  protect_from_forgery with: :exception
end
