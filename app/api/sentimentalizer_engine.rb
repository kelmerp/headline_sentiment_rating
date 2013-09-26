class SentimentalizerEngine
  def self.get_sentiment(string)
    raw_response = JSON.parse(Sentimentalizer.analyze(string))
    { "sentiment_description" => raw_response["sentiment"],
      "sentiment_score" => raw_response["probability"] }
  end
end
