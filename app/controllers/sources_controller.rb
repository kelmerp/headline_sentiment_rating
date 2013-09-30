class SourcesController < ApplicationController


  def index

  sources = Source.all

  end


  def grab_scatter
    # grab_average('http://www.foxnews.com')
    source_array = []
    # num_of_sources = Sources.all

    Source.all.each do |source|
      source_array << grab_average(source.name)
    end


    render json: source_array.flatten.to_json

  end

  def cnn_calendar
    dates = []
    json_object = []

    source = Source.find_by(name: 'http://www.cnn.com')
    dates = source.headlines.pluck(:date).uniq!
    # source.headlines.each {|d| dates << d.date.strftime("%Y-%m-%d")}
    dates.sort.each do |date|
      object = {date: date.strftime("%Y-%m-%d"), score: source.headlines.get_average(date).to_f }
      json_object << object
    end

    render json: json_object.to_json
  end

end