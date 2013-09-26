class Alchemy

  def self.alchemy_helper
    AlchemyAPI.key = ENV['alchemy']
  end

  def self.get_sentiment(string)
    AlchemyAPI.search(:sentiment_analysis, :text => string)
  end
end
