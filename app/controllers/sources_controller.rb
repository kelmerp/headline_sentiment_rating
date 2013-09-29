class SourcesController < ApplicationController


  def index

  sources = Source.all

  end

  def cnn

    dates = []
    json_object = []

    source = Source.find_by(name: 'http://www.cnn.com')

    source.headlines.limit(5000).each {|d| dates << d.date.strftime("%Y%m%d")}
    dates.uniq!.sort.reverse.each do |date|
      object = {date: DateTime.parse(date).to_i, score: source.headlines.get_average(date).to_f }
      json_object << object
    end

    render json: json_object.to_json

  end

  def fox

    dates = []
    json_object = []

    source = Source.find_by(name: 'http://www.foxnews.com')

    source.headlines.limit(5000).each {|d| dates << d.date.strftime("%Y%m%d")}
    dates.uniq!.sort.reverse.each do |date|
      object = {date: DateTime.parse(date).to_i, score: source.headlines.get_average(date).to_f }
      json_object << object
    end

    render json: json_object.to_json
    
  end

  # def fox
    
  # end
end