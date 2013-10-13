require 'csv'
path = './lib/wayback_scrapper/nytimes_headlines/headline.csv'

CSV.foreach(path) do |row|
  s = Source.find_or_create_by(:url => row[0].to_s)
  h_date = row[2].strip
  h_url = row[1].strip
  h_content = row[3].strip
  next if (h_date == nil || h_url == nil || h_content == nil)
  h = s.headlines.new(:date => h_date, :archive_url => h_url, :content => h_content)
  begin
    sentiment_data = Alchemy.get_sentiment(h.content) if h.content
  rescue
    puts "nexting"
    next
  end
  sd = h.sentiment_data.new
  sd.sentiment_description = sentiment_data['sentiment_description']
  sd.sentiment_score = sentiment_data['sentiment_score']
  sd.sentiment_engine = "Alchemy"
  sd.save
  h.save
end
