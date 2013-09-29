class SourcesController < ApplicationController


  def index

  sources = Source.all

  end

  def cnn
    source = Source.find_by(name: "http://www.cnn.com")
    dates = []
    final_array = []
    source.headlines.limit(100).each do |headline|
      dates << headline.date
    end
    dates.uniq!.reverse
    dates.each do |date|
      score = source.headlines.get_average(date.to_s)
      object = {cnn: score.to_f, thing: date}
      p object
      final_array << object
    end

    render json: final_array.to_json
  end

  # def fox
    
  # end
end