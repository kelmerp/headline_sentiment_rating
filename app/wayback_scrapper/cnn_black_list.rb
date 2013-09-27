def black_list
@black_list = 
[""," ", "LIVE TV","CNN TV", "HLN TV", "Markets", "My quotes", "Indexes", "Dow", "Nasdaq", "S&P", "Get Quotes", "CNNMoney.com", "NEW: My Portfolio", "U.S.", "World", "Politics", "Tech", "Business", "Entertainment", "Travel", "Living", "Health", "Photography", "Sports", "HLNtv.com", "TIME.com", "Indeed.com Job Search", "Play CNN Games!", "TV & Video", "HLN", "Full Schedule", " The Lead4pm ET / 1pm PT on CNN", "The Situation Room5pm ET / 2pm PT on CNN", " Erin Burnett: OutFront7pm ET / 4pm PT on CNN",
" AC 3608pm ET / 5pm PT on CNN", " Piers Morgan Live9pm ET / PT on CNN","View Collections","Home","Video",
"CNN Trends",
"U.S.",
"World",
"Politics",
"Justice",
"Entertainment",
"Tech",
"Health",
"Living",
"Travel",
"Opinion",
"iReport",
"Money",
"Sports",
"Tools & widgets",
"RSS",
"Podcasts",
"Blogs",
"CNN mobile",
"My profile",
"E-mail alerts",
"CNN shop",
"Site map",
"Contact us",
# "CNN en ESPAÑOL",
# "CNN México",
"CNN Chile",
# "CNN Expansión",
# "العربية",
# "日本語",
# "Türkçe",
"Bleacher Report",
"CNN TV",
"HLN",
"Transcripts",
"Turner Broadcasting System, Inc.","Terms of service","Privacy guidelines","Ad choices","Advertise with us","About us","Work for us","Help","CNN Newsource","License Footage", "Go", "Weather", "FULL STORY", "FULL STORY ", "TV", "Sign up", "Log in"]

end

def add_to_black_list(array)

  array.each do |item|
    @file = File.open('black_list.rb' , 'w')
    @file.puts item
  end

  # @file.close
  # array.each do |el|
  #   @black_list << el
  # end
end