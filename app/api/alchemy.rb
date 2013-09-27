class Alchemy
  def self.alchemy_helper
    AlchemyAPI.key = ENV['alchemy']
  end

  def self.get_sentiment(string)
    raw_results = AlchemyAPI.search(:sentiment_analysis, :text => string)
    raw_results["score"] = 0.0 if raw_results["score"] == nil
    raw_results["type"] = "" if raw_results["type"] == nil
    { "sentiment_description" => raw_results["type"],
      "sentiment_score" => raw_results["score"] }
  end
end
