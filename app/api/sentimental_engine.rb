class SentimentalEngine
  def self.get_sentiment(string)
    analyzer = Sentimental.new
    raw_description = analyzer.get_sentiment(string)
    raw_score = analyzer.get_score(string)
    { "sentiment_description" => raw_description.to_s,
      "sentiment_score" => raw_score }
  end
end
