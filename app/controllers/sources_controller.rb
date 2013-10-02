class SourcesController < ApplicationController

  def index
    sources = Source.all
  end

  def grab_scatter
    render json: Source.get_all_cached.flatten.to_json
  end

  def headlines
    @headlines = {}
    @date = params["param1"]
    @source_name = params["param2"]
    @source = Source.find_by(name: params["param2"])
    headline_records = @source.headlines.date(params["param1"])
    # @headlines.order(@headlines.date.to_i)
    headline_records.find_each do |headline|
      @headlines[headline.content] = headline.sentiment_data.first.sentiment_score
    end
    # p @headlines
    @headlines = @headlines.sort_by{|k, v| v }
    p @link = headline_records.first.archive_url
    html = render_to_string(:partial => 'sandbox/headlines', :layout => false,
                     :locals => {headlines: @headlines, link: headline_records.first.archive_url})

    render json: {html: html}
  end

  # def cnn_calendar
  #   dates = []
  #   json_object = []

  #   source = Source.find_by(name: 'cbsnews')
  #   dates = source.headlines.order(:date).pluck(:date).uniq
  #   # source.headlines.each {|d| dates << d.date.strftime("%Y-%m-%d")}
  #   dates.each do |date|
  #     object = {date: date.strftime("%Y-%m-%d"), score: source.headlines.get_average(date).to_f }
  #     json_object << object
  #   end

  #   render json: json_object.to_json
  # end

end
