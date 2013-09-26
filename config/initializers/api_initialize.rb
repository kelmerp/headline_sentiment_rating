AlchemyAPI.key = ENV['alchemy']

SentimentAnalysis::Client.new(:api_key => ENV['viralheat'])
# use .parsed_response for shortened answer


