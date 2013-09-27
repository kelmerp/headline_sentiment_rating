require 'csv'
path = './db/seeds/headline.csv'

# ["http://www.cnn.com", "http://web.archive.org/web/20120927230206/http://www.cnn.com/","20120927230206", "Teen dies playing 'pass out' game"]

CSV.foreach(path) do |row|
  s = Source.find_or_create_by(:name => row[0])
  h = Headline.new(:date => row[2], :archive_url => row[1], :content => row[3])
  h.source_id = s.id
  sentiment_data = Alchemy.get_sentiment(h.content)
  h.sentiment_description = sentiment_data['sentiment_description']
  h.sentiment_score = sentiment_data['sentiment_score']
  h.sentiment_engine = "Alchemy"
  h.save
end