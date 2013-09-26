class Alchemy
  def self.alchemy_helper
    AlchemyAPI.key = ENV['alchemy']
  end

  def self.get_sentiment(string)
    raw_results = AlchemyAPI.search(:sentiment_analysis, :text => string)
    raw_score = 0.0 if raw_results["score"] == nil
    { "sentiment_description" => raw_results["type"],
      "sentiment_score" => raw_score }
  end
end
