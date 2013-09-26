class ViralHeat
  def self.sa_helper
    SentimentAnalysis::Client.new(:api_key => ENV['viralheat'])
  end

  def self.get_sentiment(string)
    raw_response = ViralHeat.sa_helper.review(:text => string)
    { "sentiment_description" => raw_response.parsed_response["mood"],
      "sentiment_score" => raw_response.parsed_response["prob"] }
  end
end
